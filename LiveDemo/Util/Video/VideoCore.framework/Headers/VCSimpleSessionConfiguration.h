/*
 
 Video Core
 Copyright (c) 2015 Andy Young @ Baidu.com Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  @brief 摄像头枚举定义
 */
typedef NS_ENUM(NSInteger, VCCameraState) {
    /**
     *  前置摄像头
     */
    VCCameraStateFront,
    /**
     *  后置摄像头
     */
    VCCameraStateBack
};

/**
 *  @brief H264编码Profile定义。 目前支持Baseline和High，默认为High。
 */
typedef NS_ENUM(NSInteger, VCH264Profile) {
    /**
     *  编码质量一般，能耗低。
     */
    VCH264ProfileBaseline,
    /**
     *  编码质量高，能耗高。 默认为High。
     */
    VCH264ProfileHigh
};

/**
 *  @brief 音频采样率定义
 */
typedef NS_ENUM(NSInteger, VCAudioSampleRate) {
    /**
     *  22.05KHz
     */
    VCAudioSampleRate22050 = 22050,
    
    /**
     *  44.1KHz
     */
    VCAudioSampleRate44100 = 44100,
};

/**
 *  @brief 音频码率
 */
typedef NS_ENUM(NSUInteger, VCAudioBitrate) {
    /**
     *  64K。
     *  建议在VCAudioSampleRate22050下使用。
     */
    VCAudioBitrate64000 = 64000,
    /**
     *  96K
     */
    VCAudioBitrate96000 = 96000,
    /**
     *  128K
     */
    VCAudioBitrate128000 = 128000,
    /**
     *  192K
     */
    VCAudioBitrate192000 = 192000,
};

/**
 *  @brief 美颜级别定义
 */
typedef NS_ENUM(NSInteger, VCBeautyLevel) {
    /**
     *  不开启美颜。
     */
    VCBeautyLevelNone,
    /**
     *  自然。基本去皱，适当美白提亮
     */
    VCBeautyLevelNatural,
    /**
     *  美白。去皱但不失真，以美白为主粉嫩为辅
     */
    VCBeautyLevelWhiten,
    /**
     *  粉嫩。去皱但不失真，以粉嫩为主美白为辅
     */
    VCBeautyLevelPink,
    /**
     *  梦幻。最大值
     */
    VCBeautyLevelMagic
};

/**
 *  @brief 配置类。初始化VCSimpleSession时使用。
 */
@interface VCSimpleSessionConfiguration : NSObject

// 视频相关的设置

/**
 *  @brief 是否推视频。默认值为YES。推流过程中，可调用VCSimpleSession的接口修改。
 */
@property(nonatomic, assign) BOOL videoEnabled;

/**
 *  @brief 视频分辨率，默认为720 * 1280, 竖屏方式。推流过程中无法修改。
 */
@property(nonatomic, assign) CGSize videoSize;

/**
 *  @brief 视频码率，默认为1200K。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger bitrate;

/**
 *  @brief 视频帧率，默认为15帧每秒。取值范围[0, 30)。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger fps;

/**
 *  @brief 视频H264编码的Profile。默认为VCH264ProfileHigh，编码质量高，能耗高。推流过程中无法修改。
 */
@property(nonatomic, assign) VCH264Profile profile;

/**
 *  @brief 关键帧间隔，默认为2秒。取值范围[2, 10]。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger gopLength;

// 音频相关的设置

/**
 *  @brief 是否推音频。默认为YES。推流过程中，可调用VCSimpleSession的接口修改。
 */
@property(nonatomic, assign) BOOL audioEnabled;

/**
 *  @brief 音频码率。默认值为VCAudioBitrate96000。推流过程中无法修改。
 */
@property(nonatomic, assign) VCAudioBitrate audioBitrate;

/**
 *  @brief 声道数。默认为2。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger audioChannelCount;

/**
 *  @brief 音频采样率，默认为VCAudioSampleRate44100。推流过程中无法修改。
 */
@property(nonatomic, assign) VCAudioSampleRate audioSampleRate;

// 摄像头相关设置

/**
 *  @brief 使用哪个摄像头。默认为后置摄像头。推流过程中，可调用VCSimpleSession的接口切换。
 */
@property(nonatomic, assign) VCCameraState cameraDevice;

/**
 *  @brief 摄像头方向。默认为正肖像方向。推流过程中无法修改。
 */
@property(nonatomic, assign) AVCaptureVideoOrientation cameraOrientation;

/**
 *  @brief 是否开启闪光灯。默认为NO。推流过程中，可调用VCSimpleSession的接口切换。
 */
@property(nonatomic, assign) BOOL torch;

/**
 *  @brief 是否开启摄像头的实时自动对焦。默认为YES。推流过程中，可调用VCSimpleSession的接口修改。
 */
@property(nonatomic ,assign) BOOL continuousAutofocus;

/**
 *  @brief 是否开启摄像头动态测光。默认为YES。推流过程中，可调用VCSimpleSession的接口修改。
 */
@property(nonatomic ,assign) BOOL continuousExposure;

// 麦克风相关设置

/**
 *  @brief 麦克风音量增益。默认值为1。取值范围[0, 1]。推流过程中，可调用VCSimpleSession的接口修改。
 */
@property(nonatomic, assign) float micGain;

/**
 *  @brief 程序前后台切换时，是否启停音频采集。默认为YES。如果不启停，App需要有后台任务权限和相关处理。推流过程中无法修改。
 */
@property(nonatomic, assign) BOOL pauseAudioWhenInBackground;

// 其他设置

/**
 *  @brief 是否启用动态码率。默认为YES。推流过程中无法修改。
 */
@property(nonatomic, assign) BOOL useAdaptiveBitrate;

/**
 *  @brief 动态码率灵敏度。默认为5。取值范围[5, 10]。值越小越灵敏。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger sensibility;

/**
 *  @brief 允许的最大码率。默认值为1M。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger maxBitrate;

/**
 *  @brief 允许的最低码率。默认值为200K。推流过程中无法修改。
 */
@property(nonatomic, assign) NSUInteger minBitrate;


@end