//
//  HomeApiManager.m
//  HaiTao
//
//  Created by lxm on 15/4/29.
//  Copyright (c) 2015年 lxm. All rights reserved.
//

#import "HomeApiManager.h"
#import "HomeDataModel.h"

@implementation HomeApiManager
static HomeApiManager *shared_manager = nil;

+ (HomeApiManager *)sharedManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
        shared_manager.dicOfTasks = [[NSMutableDictionary alloc] init];
    });
    return shared_manager;
}

/**
 *  获取首页数据接口
 *
 *  @param dic
 *  @param success data
 *  @param failure error
 */
- (void)requestHomeData:(NSDictionary *)dic
                withURL:(NSString *)urlStr
                Success:(void (^)(id data))success
                failure:(void (^)(NSError *error))failure
{
    [self fetchDataTask:urlStr];
    NSDictionary * params = [[HTBaseAPIClient sharedClient] fetchParameters:dic withMethod:@"homedata"];
    NSMutableURLRequest *request = [[HTBaseAPIClient sharedClient].requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    NSLog(@"-------------start");
    NSURLSessionDataTask *dataTask = [[HTBaseAPIClient sharedClient] dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            failure(error);
        } else {
            NSLog(@"-----------------end%@ %@", response, responseObject);
            [self parseHomeData:responseObject success:success failure:failure];
        }
    }];
    [dataTask resume];
    [self.dicOfTasks setObject:dataTask forKey:urlStr];
}

- (void)parseHomeData:(id)doc success:(void (^)(id data))success failure:(void (^)(NSError *error))failure
{
    /**
     *  检测json数据合法性，result ＝ 1 才进行实体化
     */
    if([self handleMessageError:doc success:success failure:failure])
        return;
    /**
     *  json－》实体类
     */
    NSError *jsonError=nil;
    HomeDataModel* rModel = [[HomeDataModel alloc] initWithString:[doc JSONString] error:&jsonError];
    if(jsonError)
        failure(jsonError);
    success(rModel);
}

@end
