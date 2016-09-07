//
//  HomeApiManager.h
//  HaiTao
//
//  Created by lxm on 15/4/29.
//  Copyright (c) 2015年 lxm. All rights reserved.
//

#import "HTBaseAPIManager.h"
@interface HomeApiManager : HTBaseAPIManager
+ (HomeApiManager *)sharedManager;



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
                failure:(void (^)(NSError *error))failure;

@end
