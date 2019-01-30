#import "QNResolverDelegate.h"
#import <Foundation/Foundation.h>
@interface QNDnspodFree : NSObject <QNResolverDelegate>
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError *__autoreleasing *)error;
- (instancetype)init;
- (instancetype)initWithServer:(NSString *)server;
- (instancetype)initWithServer:(NSString *)server
                       timeout:(NSUInteger)time;
@end
