//
//  StreamingPortraitViewController.m
//  LiveDemo
//
//  Created by 白璐 on 16/8/10.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "StreamingPortraitViewController.h"
#import "StreamingViewModel.h"

@implementation StreamingPortraitViewController

- (AVCaptureVideoOrientation)cameraOrientation {
    return AVCaptureVideoOrientationPortrait;
}

@end
