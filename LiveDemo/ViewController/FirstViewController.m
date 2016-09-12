//
//  FirstViewController.m
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeApiManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self httpRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequest
{
    http://www.lxm.com/live_demo/api.php?act=loginregist&op=login&account=lxm&password=0f4ca9f025a2e3adc0acb6e6fc890486
    [[HomeApiManager sharedManager] requestHomeData:nil withURL:@"http://www.lxm.com/live_demo/api.php?act=loginregist&op=homedata" Success:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
