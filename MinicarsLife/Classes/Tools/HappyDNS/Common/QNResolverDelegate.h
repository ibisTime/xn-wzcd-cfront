#import <Foundation/Foundation.h>
extern const int kQNDomainHijackingCode;
extern const int kQNDomainNotOwnCode;
extern const int kQNDomainSeverError;
#define QN_DNS_DEFAULT_TIMEOUT 20 
@class QNDomain;
@class QNNetworkInfo;
@protocol QNResolverDelegate <NSObject>
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError **)error;
@end
