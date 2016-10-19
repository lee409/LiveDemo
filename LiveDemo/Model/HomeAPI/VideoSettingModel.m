//
//  VideoSettingModel.m
//  LiveDemo
//
//  Created by lxm on 16/8/10.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "VideoSettingModel.h"

@implementation VideoSettingModel

- (instancetype)init {
    if (self = [super init]) {
        _url = @"rtmp://push.bcelive.com/live/v0erj1ai26dq0eacg2";
        _resolution = Resolution_720P;
        _direction = DirectionPortrait;
    }
    
    return self;
}

@end
