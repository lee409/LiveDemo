//
//  BaseVC.h
//  LearnEasy
//
//  Created by lxm on 14-11-16.
//  Copyright (c) 2014年 lxm. All rights reserved.
//
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface BaseVC : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    BOOL isShownEmpty;
    BOOL isAddConnectView;
    BOOL isCheckConnection;
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)image;
- (NSString *)getCurrentDeviceModel;
@end
