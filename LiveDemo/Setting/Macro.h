/*
 *Created by lxm on 12-3-13.
 */


/** all comment Macro define in here ***/


#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
#define iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7?YES:NO)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8?YES:NO)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9?YES:NO)

//**** 调试输出 ****
#ifdef DEBUG
    #define CSLOG(_format,args...)  printf("%s\n",[[NSString stringWithFormat:(_format),##args] UTF8String])
    #define LOG(xx, ...)  DOLOG(@"\n##%s(%d)##" xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define CSLOGDATA(__DATA) LOG(@"%@",[[NSString alloc]initWithData:__DATA encoding:NSUTF8StringEncoding]])
#else
    #define CSLOG(_format,args...)
    #define LOG(xx, ...)
    #define CSLOGDATA(__DATA)
#endif


//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


#define SAFELY_RELEASE(obj)  {if(obj != nil) { [obj release]; obj = nil;}}

//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//**** 计算数组大小 ****
#define countof(x)      (sizeof(x)/sizeof((x)[0]))

// rgb颜色转换（16进制->10进制）
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define kClearColor [UIColor clearColor]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//#define CSAlert(_S_)     [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil) message:_S_ delegate:nil cancelButtonTitle:NSLocalizedString(@"知道了",nil) otherButtonTitles:nil] show]

#define CSAlert(_S_) \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:_S_ preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];

#define CSAlertInAppDelegate(_S_) \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:_S_ preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];[[[UIApplication sharedApplication]delegate].window.rootViewController presentViewController:alert animated:YES completion:nil];

#define IsNOTNullOrEmptyOfArray(_ARRAY___) (_ARRAY___ && [_ARRAY___ isKindOfClass:[NSArray class]] && [_ARRAY___ count])

#define IsNOTNullOrEmptyOfNSString(_STRING___) (_STRING___ && [_STRING___ isKindOfClass:[NSString class]] && [_STRING___ length])
#define IsNOTNullOrEmptyOfNSNumber(_NUMBER___) (_NUMBER___ && [_NUMBER___ isKindOfClass:[NSNumber class]] )


#define IsNOTNullOrEmptyOfDictionary(_DICTIONARY___) (_DICTIONARY___ && [_DICTIONARY___ isKindOfClass:[NSDictionary class]] && [_DICTIONARY___ count])
#define IsNullObj(____object____) ((____object____ && [____object____ isKindOfClass: [NSNull class]]) || (____object____ == nil))


#define ProcessString(___strx___) ((!IsNOTNullOrEmptyOfNSString(___strx___))?@"":___strx___)

#define isContainView(superView,subView) [[superView subviews] containsObject:subView]



/*配置*/
#define FZLanTingFontStyle  @"FZLTHJW--GB1-0"
/*导航栏标题*/
#define HTNavBarTitleAttributes  @{NSFontAttributeName:[UIFont systemFontOfSize:18.f],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0x333333"],}
/*导航栏按钮*/
#define HTNavBarButtonAttributes  @{NSFontAttributeName:[UIFont systemFontOfSize:16.f],NSForegroundColorAttributeName: RGB(207,79, 58),}

/*主题颜色*/
#define HTTopicMainColor [UIColor colorWithHexString:@"0xff3366"]
#define HTTopicCleanColor [UIColor colorWithHexString:@"0xcccccc"]
#define HTTextColor RGB(67,67,67)
#define HTGoldenColor [UIColor colorWithHexString:@"0xff3366"]
#define HTUITableViewSeparatorColor [UIColor colorWithHexString:@"0xcccccc"]
/*屏幕大小*/
#define HTScreenWidth [[UIScreen mainScreen]bounds].size.width
#define HTScreenHeight [[UIScreen mainScreen]bounds].size.height

#define Is320Width ((int)[UIScreen mainScreen].bounds.size.width == 320?YES:NO)
#define Is375Width ((int)[UIScreen mainScreen].bounds.size.width == 375?YES:NO)
#define Is414Width ((int)[UIScreen mainScreen].bounds.size.width == 414?YES:NO)

/**
 判断分享事件，是否是订单商品完成后，分享领红包
 */
#define IsShareFromRedEnvelope @"ShareFromRedEnvelope"
/**
 分享事件完成后，回调app，此时，如果是来源于订单分享领红包该动作，则需要发送该通知
 */
#define ShareRedEnvelopeRecallNoti @"ShareRedEnvelopeRecallNoti"

enum isShoppingCartCome {
    HTComeFromSearch  = 1,        /**< 搜索    */
    HTComeFromCate = 2,           /**< 二级分类      */
    HTComeFromTabbar = 0,         /**< tabbar       */
};

enum shareCollectType {
    HTShareCollectComeFromGoods  = 1,        /**< 商品    */
    HTShareCollectComeFromH5 = 2,         /**< H5       */
    HTShareCollectComeFromDiscover = 3,         /**< 发现       */
    HTShareCollectComeFromSetting = 4,        /**< 设置分享app      */
    HTShareCollectComeFromGroupbuy = 5         /**< 设置分享app      */
};