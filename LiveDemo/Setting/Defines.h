//
//  Defines.h
//  LiveDemo
//
//  Created by 白璐 on 16/8/10.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  @brief 分辨率定义
 */
typedef NS_ENUM(NSInteger,  Resolution) {
    /**
     *  1080P 定义
     */
    Resolution_1080P = 1080,
    /**
     *  720P 定义
     */
    Resolution_720P = 720,
    /**
     *  480P 定义
     */
    Resolution_480P = 480,
    /**
     *  360P 定义
     */
    Resolution_360P = 360,
};

/**
 *  @brief 摄像头的方向
 */
typedef NS_ENUM(NSInteger, Direction) {
    /**
     *  肖像、竖屏
     */
    DirectionPortrait,
    /**
     *  风景、横屏
     */
    DirectionLandscape,
};


@interface ResolutionHelper : NSObject

+ (CGSize)size:(Resolution)resolution direction:(Direction)direction;

@end

@interface BitrateHelper : NSObject

+ (NSUInteger)bitrate:(Resolution)resolution;

@end