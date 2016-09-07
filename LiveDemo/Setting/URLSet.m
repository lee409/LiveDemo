//
//  URLSet.m
//  leju_platform
//
//  Created by freeblow on 13-7-31.
//  Copyright (c) 2013年 Leju. All rights reserved.
//

#import "URLSet.h"

#define urlHost() @"http://api1.test.hiooy.com/index.php?"
#define urlCommonHost() @"http://sit1.test.hiooy.com/wap/index.php?"

#define SubUrl(subUrl) subUrl
#define RealUrl(x)  urlHost()SubUrl(x)    //正式地址
#define RealCommonUrl(x)  urlCommonHost()SubUrl(x)    //正式地址
//所有的url

NSString *const HTHostURL = urlHost();
NSString *const HTCommonURL = urlCommonHost();
//首页
NSString *const HTHomePageURL = RealCommonUrl(@"act=app_index&op=app_index");

