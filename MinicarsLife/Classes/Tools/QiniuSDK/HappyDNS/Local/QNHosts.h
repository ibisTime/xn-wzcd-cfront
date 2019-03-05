#import "QNResolverDelegate.h"
#import <Foundation/Foundation.h>
@interface QNHosts : NSObject
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo;
- (void)put:(NSString *)domain ip:(NSString *)ip;
- (void)put:(NSString *)domain ip:(NSString *)ip provider:(int)provider;
- (instancetype)init;
@end
