//
//  VideoSettingViewModel.h
//  LiveDemo
//
//  Created by lxm on 16/8/10.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "Defines.h"

@interface VideoSettingViewModel : NSObject

/**
 *  @brief 推流地址
 */
@property(nonatomic, copy) NSString* url;

/**
 *  @brief 分辨率
 */
@property(nonatomic, assign) Resolution resolution;

/**
 *  @brief 方向
 */
@property(nonatomic, assign) Direction direction;

@end
