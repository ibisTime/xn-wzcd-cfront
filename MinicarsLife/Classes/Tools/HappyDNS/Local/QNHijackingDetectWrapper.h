#import <Foundation/Foundation.h>
#import "QNResolverDelegate.h"
@class QNResolver;
@interface QNHijackingDetectWrapper : NSObject <QNResolverDelegate>
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError *__autoreleasing *)error;
- (instancetype)initWithResolver:(QNResolver *)resolver;
@end
