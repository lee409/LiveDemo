//
//  FirstViewController.m
//  LiveDemo
//
//  Created by lxm on 16/9/6.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeApiManager.h"
#import "FFMpegTestViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"FFMpegTestViewController"]){

    }
}

- (IBAction)ffMpegAction
{
    NSString *path = @"http://weisili.gz.bcebos.com/lss-gjmk9t2h7icg8rm1/recording_20161019183218.mp4";//@"http://ols.lmschina.net/resources/resource/1281/20165915.mp4";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path parameters:parameters];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)httpRequest
{
    http://www.lxm.com/live_demo/api.php?act=loginregist&op=login&account=lxm&password=0f4ca9f025a2e3adc0acb6e6fc890486
    [[HomeApiManager sharedManager] requestHomeData:nil withURL:@"http://www.lxm.com/live/api.php?act=loginregist&op=homedata" Success:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
