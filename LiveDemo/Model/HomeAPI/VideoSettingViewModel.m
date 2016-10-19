//
//  SettingViewModel.m
//  LiveDemo
//
//  Created by 白璐 on 16/8/10.
//  Copyright © 2016年 HaiShang. All rights reserved.
//

#import "VideoSettingViewModel.h"
#import "VideoSettingModel.h"

@interface VideoSettingViewModel ()
@property(nonatomic, strong) VideoSettingModel* model;
@end

@implementation VideoSettingViewModel

- (instancetype)init {
    if (self = [super init]) {
        _model = [[VideoSettingModel alloc] init];
    }
    
    return self;
}

- (NSString*)url {
    return _model.url;
}

- (void)setUrl:(NSString *)url {
    _model.url = url;
}

- (Resolution)resolution {
    return _model.resolution;
}

- (void)setResolution:(Resolution)resolution {
    _model.resolution = resolution;
}

- (Direction)direction {
    return _model.direction;
}

- (void)setDirection:(Direction)direction {
    _model.direction = direction;
}

@end
