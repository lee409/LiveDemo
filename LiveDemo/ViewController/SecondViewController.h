//
//  SecondViewController.h
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoSettingViewModel.h"

@interface SecondViewController : UIViewController<UINavigationControllerDelegate>

@property(nonatomic, strong) VideoSettingViewModel* model;

@end

