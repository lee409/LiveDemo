//
//  HTBaseAPIManager.m
//  
//
//  Created by lxm on 13-10-12.
//  Copyright (c) 2013年 lxm. All rights reserved.
//

#import "HTBaseAPIManager.h"
static HTBaseAPIManager *shared_manager = nil;

@implementation HTBaseAPIManager
+ (HTBaseAPIManager *)sharedManager {
    static dispatch_once_t pred;
	dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
	return shared_manager;
}

- (BOOL)handleMessageError:(id)doc success:(void (^)(id data))success failure:(void (^)(NSError *error))failure
{
    NSString *resultStr = [doc objectForKey:@"code"];
    if(!resultStr)
    {
        NSError *err = [NSError errorWithDomain:CSBase_ERROR_DEMAIN code:API_RequestURL_NotFound_Error_Code userInfo:[NSDictionary dictionaryWithObject:@"接口异常" forKey:NSLocalizedDescriptionKey]];
        failure(err);
    }
    else
    {
        if([resultStr intValue]== 0)
            return NO;
        else
        {
            if ([resultStr intValue]== API_Not_Match_ErrorCode||[resultStr intValue]==998) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTViewcontrollerNotificationFailureRefreshIdentifer" object:nil];
            }
            
            NSError *err;
            if ([resultStr intValue] == API_Password_ErrorCode) {
                NSString *message = [doc objectForKey:@"message"];
                if (!IsNOTNullOrEmptyOfNSString(message)) {
                    message = @"message为空！";
                }
                err = [NSError errorWithDomain:CSBase_ERROR_DEMAIN code:API_Password_ErrorCode userInfo:[NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey]];
            }else{
                NSString *message = [doc objectForKey:@"message"];
                if (!IsNOTNullOrEmptyOfNSString(message)) {
                    message = @"message为空！";
                }
                
               err = [NSError errorWithDomain:CSBase_ERROR_DEMAIN code:API_RequestURL_NotFound_Error_Code userInfo:[NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey]];
            }
            
            failure(err);
            return YES;
        }
    }
    return YES;
}

- (NSString *)progressResponse:(NSString *)res;
{
    NSMutableString *responseString = [NSMutableString stringWithString:res];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
        [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    NSLog(@"responst=%@",responseString);
    return responseString;
}

- (void)fetchDataTask:(NSString *)keyIdentify
{
    NSDictionary *tempDic = self.dicOfTasks;
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSURLSessionDataTask *taskObj, BOOL * _Nonnull stop) {
        if([keyIdentify isEqualToString:key]){
            if(stop){
                if(taskObj.state == NSURLSessionTaskStateRunning)
                    [taskObj cancel];
                [self.dicOfTasks removeObjectForKey:key];
            }
        }
    }];
}
#pragma mark - CommonAPI
/**
 *
 *  上传图片
 *
 *  @param dic     参数
 *  @param object  view
 *  @param success success
 *  @param failure failure
 */
- (void)uploadImage:(NSDictionary *)dic
           progress:(id )object
            Success:(void (^)(id data))success
            failure:(void (^)(NSError *error))failure
{
//    NSDictionary *params = [[HTBaseAPIClient sharedClient] fetchParameters:dic];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:HTUploadImageURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:[params objectForKey:@"data"] name:@"head" fileName:@"Icon.png" mimeType:@"image/png"];
//    } error:nil];
//    NSData *data = [params objectForKey:@"data"];
//    NSProgress *progressData = [NSProgress progressWithTotalUnitCount:data.length];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progressData completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//            failure(error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//            success(responseObject);
//        }
//        
//    }];
//    
//    [uploadTask resume];
//    [progressData addObserver:object
//                   forKeyPath:@"fractionCompleted"
//                      options:NSKeyValueObservingOptionNew
//                      context:NULL];
    
}
@end
