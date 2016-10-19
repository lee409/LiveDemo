//
//  SecondViewController.m
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "SecondViewController.h"
#import "VideoSettingViewModel.h"
#import "StreamingViewController.h"
#import "StreamingViewModel.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.model = [[VideoSettingViewModel alloc] init];
    self.model.url = @"rtmp://push.bcelive.com/live/v0erj1ai26dq0eacg2";
    self.model.direction = DirectionPortrait;
    self.model.resolution = Resolution_360P;
    self.navigationController.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)onStream:(id)sender {
    NSString* name;
    if (self.model.direction == DirectionPortrait) {
        name = @"StreamingPortrait";
    } else {
        name = @"StreamingLandscape";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard* board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StreamingViewController* vc = (StreamingViewController*)[board instantiateViewControllerWithIdentifier:name];
        StreamingViewModel* vm = [[StreamingViewModel alloc] initWithSettingViewModel:self.model];
        vc.model = vm;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    if (self.model.direction == DirectionPortrait) {
        return;
    }
    
    if (viewController != self) {
        [self rotateVC:M_PI_2];
    } else {
        [self rotateVC:-M_PI_2];
    }
}

- (void)rotateVC:(CGFloat)angle {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGPoint center = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    self.navigationController.view.center = center;
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    if (angle < 0) {
        transform = CGAffineTransformIdentity;
    }
    self.navigationController.view.transform = transform;
    
    CGRect bounds = CGRectMake(0, 0, screenSize.height , screenSize.width);
    if (angle < 0) {
        bounds = CGRectMake(0, 0, screenSize.width , screenSize.height);
    }
    
    self.navigationController.view.bounds = bounds;
}
@end
