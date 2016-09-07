//
//  BaseWebVC.h
//  HaiTao
//
//  Created by Damon on 15/12/10.
//  Copyright © 2015年 HaiShang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface BaseWebVC : BaseVC{
    UIWebView *_webView;
}
@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,strong)NSString *navTitleStr;
@end
