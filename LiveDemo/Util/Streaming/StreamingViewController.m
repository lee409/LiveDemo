//
//  StreamingViewController.m
//  LiveDemo
//
//  Created by 白璐 on 16/8/10.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "StreamingViewController.h"
#import "StreamingViewModel.h"
#import <VideoCore/VideoCore.h>

@interface StreamingViewController () <VCSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *torchButton;
@property (weak, nonatomic) IBOutlet UIButton *beautyButton;
@property (weak, nonatomic) IBOutlet UIButton *streamButton;

@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTapGesture;

@property (assign, nonatomic) BOOL isBacking;
@end

@implementation StreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isBacking = NO;
    
    [self.model setupSession:[self cameraOrientation] delegate:self];
    [self.model preview:self.view];
    
    self.tapGesture.numberOfTapsRequired = 1;
    self.doubleTapGesture.numberOfTapsRequired = 2;
    [self.tapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
}

- (AVCaptureVideoOrientation)cameraOrientation {
    return AVCaptureVideoOrientationPortrait;
}

- (void)viewDidLayoutSubviews {
    [self.model updateFrame:self.view];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - action

- (IBAction)onBack:(id)sender {
    self.isBacking = YES;
    BOOL result = [self.model back];
    if (!result) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)onToggleFlash:(id)sender {
    BOOL toggle = [self.model toggleTorch];
    if (toggle) {
        [self.torchButton setBackgroundImage:[UIImage imageNamed:@"flash_on"] forState:UIControlStateNormal];
    } else {
        [self.torchButton setBackgroundImage:[UIImage imageNamed:@"flash_off"] forState:UIControlStateNormal];
    }
}

- (IBAction)onSwitchCamera:(id)sender {
    [self.model switchCamera];
}

- (IBAction)onBeauty:(id)sender {
    BOOL toggle = [self.model toggleBeauty];
    if (toggle) {
        [self.beautyButton setBackgroundImage:[UIImage imageNamed:@"beauty_on"] forState:UIControlStateNormal];
    } else {
        [self.beautyButton setBackgroundImage:[UIImage imageNamed:@"beauty_off"] forState:UIControlStateNormal];
    }
}

- (IBAction)onToggleStream:(id)sender {
    [self.model toggleStream];
}

- (IBAction)onPinch:(id)sender {
    [self.model pinch:self.pinchGesture.scale state:self.pinchGesture.state];
}

- (IBAction)onTap:(id)sender {
    CGPoint point = [self.tapGesture locationInView:self.view];
    point.x /= self.view.frame.size.width;
    point.y /= self.view.frame.size.height;
    
    [self.model setInterestPoint:point];
}

- (IBAction)onDoubleTap:(id)sender {
    [self.model zoomIn];
}

#pragma mark - VCSessionDelegate
- (void) connectionStatusChanged: (VCSessionState) sessionState {
    switch(sessionState) {
        case VCSessionStatePreviewStarted:
            break;
        case VCSessionStateStarting:
            NSLog(@"Current state is VCSessionStateStarting\n");
            break;
        case VCSessionStateStarted:
            NSLog(@"Current state is VCSessionStateStarted\n");
            [self.streamButton setBackgroundImage:[UIImage imageNamed:@"streaming"] forState:UIControlStateNormal];
            break;
        case VCSessionStateError:
            NSLog(@"Current state is VCSessionStateError\n");
            [self.streamButton setBackgroundImage:[UIImage imageNamed:@"stream_background"] forState:UIControlStateNormal];
            break;
        case VCSessionStateEnded:
            NSLog(@"Current state is VCSessionStateEnded\n");
            [self.streamButton setBackgroundImage:[UIImage imageNamed:@"stream_background"] forState:UIControlStateNormal];
            if (self.isBacking) {
                [self.navigationController popViewControllerAnimated:YES];
                self.isBacking = NO;
            }
            break;
        default:
            break;
    }
}

@end
