#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HTBaseAPIClient : AFHTTPSessionManager
@property(nonatomic,strong)NSString *preMethod;

+ (instancetype)sharedClient;

- (NSDictionary *)fetchParameters:(NSDictionary *)dic withMethod:(NSString *)methodStr;
- (NSString *)md5:(NSString *)str;
@end
