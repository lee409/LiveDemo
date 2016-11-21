//
//  HTBaseAPIManager.h
//
//
//  Created by lxm on 13-10-12.
//  Copyright (c) 2013年 lxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTBaseAPIClient.h"
@interface HTBaseAPIManager : NSObject
@property(nonatomic,strong)NSMutableDictionary *dicOfTasks;
+ (HTBaseAPIManager *)sharedManager;

- (BOOL)handleMessageError:(id)doc success:(void (^)(id data))success failure:(void (^)(NSError *error))failure;

- (NSString *)progressResponse:(NSString *)res;

- (void)fetchDataTask:(NSString *)keyIdentify;
#pragma mark - CommonAPI
/**
 *  上传图片
 *
 *  @param dic
 *  @param success data
 *  @param failure error
 */
- (void)uploadImage:(NSDictionary *)dic
           progress:(id )object
            Success:(void (^)(id data))success
            failure:(void (^)(NSError *error))failure;
@end
