#import "HTBaseAPIManager.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h>
#import <sys/sysctl.h>

@implementation HTBaseAPIClient

+ (instancetype)sharedClient {
    static HTBaseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HTBaseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:HTHostURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        size_t size;
        sysctlbyname ("hw.machine" , NULL , &size ,NULL ,0);
        char *model = (char *)malloc(size);
        sysctlbyname ("hw.machine" , model , &size ,NULL ,0);
        NSString * strModel = [NSString stringWithCString: model
                                                 encoding:NSUTF8StringEncoding];
        NSString *appVersion = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
        NSString *sys_version = [UIDevice currentDevice].systemVersion;
        //identifierForVendor 存取userdefault
        NSString *idfv=nil;
        NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
        if([uDefaults objectForKey:@"uuid"])
            idfv = [uDefaults objectForKey:@"uuid"];
        else{
            idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [uDefaults setObject:idfv forKey:@"uuid"];
            [uDefaults synchronize];
        }
        NSString *userid = [uDefaults objectForKey:@"user_id"];
        
        NSDictionary *dic = @{@"user_id":userid?userid:@"0",
                              @"mobile_model":strModel,
                              @"sys_version":sys_version,
                              @"app_version":appVersion,
                              @"uuid":idfv
                              };
        [_sharedClient.requestSerializer setValue:[dic JSONString] forHTTPHeaderField:@"User-data"];
        
        //设置返回类型
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];


    });
    
    return _sharedClient;
}

- (NSDictionary *)fetchParameters:(NSDictionary *)dic withMethod:(NSString *)methodStr
{
    NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [uDefaults objectForKey:@"user_id"];
    NSString *userToken = [uDefaults objectForKey:@"tokenCode"];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [params setObject:userId?userId:@"0" forKey:@"user_id"];
    NSString* vcode = [self sign:methodStr strParams:@"com.lxm.live"];
    [params setObject:userToken?userToken:@"0" forKey:@"tokenCode"];
    [params setObject:vcode forKey:@"vcode"];
    [params setObject:[self timestamp] forKey:@"reqtime"];

    return params;
}

- (NSString*)timestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    return [NSString stringWithFormat:@"%.0f", a];
}

- (NSString*)sign:(NSString*)methodName strParams:(NSString*)params
{
    // 规则
    // token + md5( “methodName” + params + md5( userCode 的前六位 ))
    NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userCode = [uDefaults objectForKey:@"user_id"];
    NSString *token = [uDefaults objectForKey:@"tokenCode"];

    NSMutableString* vCode = [[NSMutableString alloc]init];
    NSString* skey = [self md5:[userCode substringToIndex:6]];
    [vCode appendString:token];
    NSString *key = [[methodName stringByAppendingString:params] stringByAppendingString:skey];
    [vCode appendString:[self md5:key]];
    NSLog(@"userCode 的前六位=%@",[userCode substringToIndex:6]);
    NSLog(@"md5( userCode 的前六位 )=%@",skey);
    NSLog(@"“methodName” + params + md5( userCode 的前六位 )=%@",key);
    NSLog(@"md5( “methodName” + params + md5( userCode 的前六位 )=%@",[self md5:key]);
    NSLog(@"token + md5( “methodName” + params + md5( userCode 的前六位 ))=%@",vCode);
    return vCode;
}

/**
 *  md5
 *
 *  @param NSString str
 *
 *  @return NSString
 */
- (NSString *)md5:(NSString *)strDes {
    const char* str = [strDes UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
@end
