//
//  BaseNavVC.m
//  LearnEasy
//
//  Created by lxm on 15/5/27.
//  Copyright (c) 2015年 lxm. All rights reserved.
//

#import "BaseNavVC.h"

@interface BaseNavVC ()

@end

@implementation BaseNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [UINavigationBar appearance].barTintColor =[UIColor colorWithHexString:@"0xf7f8f9"];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"0x7d7d7d"]];/*导航栏按钮文字颜色*/
    [[UINavigationBar appearance] setTitleTextAttributes:HTNavBarTitleAttributes];/*导航栏标题颜色*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}
@end
