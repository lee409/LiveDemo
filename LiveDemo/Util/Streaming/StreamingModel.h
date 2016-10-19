//
//  StreamingModel.h
//  LiveDemo
//
//  Created by 白璐 on 16/8/10.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VideoSettingModel.h"

@class VCSimpleSession;

@interface StreamingModel : VideoSettingModel
@property(nonatomic, strong) VCSimpleSession* session;
@property(nonatomic, assign) BOOL beautyEnabled;
@end
