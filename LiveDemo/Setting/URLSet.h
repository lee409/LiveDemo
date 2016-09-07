//
//  URLSet.h
//  leju_platform
//
//  Created by freeblow on 13-7-31.
//  Copyright (c) 2013年 Leju. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MTAKey @"I8GNKN8L6E7P"

/*生产环境信鸽推送*/
#define XingeAccessID
#define XingeAccessKey @""

#define WechatAppID @"" /* 海印生活圈 */
#pragma mark -
#pragma mark - API Return Code
#define API_Sucess_Code                     200
#define API_IDType_Error_Code               400
#define API_NotAuthorized_Error_Code        401
#define API_PayMent_Required_Error_Code     402
#define API_Forbidden_Error_Code            403
#define API_RequestURL_NotFound_Error_Code  404
#define API_Server_Error_Code               500
#define API_Not_Implemented_Error_Code      501
#define API_Not_Match_ErrorCode             999
#define API_Password_ErrorCode              998
#define API_Seckill_ErrorCode               777
#define CSBase_ERROR_DEMAIN                     @"MESSAGE_ERROR"

extern NSString *const HTHostURL;
extern NSString *const HTCommonURL;
//所有的url
//首页
extern NSString *const HTHomePageURL;                   //首页页面
