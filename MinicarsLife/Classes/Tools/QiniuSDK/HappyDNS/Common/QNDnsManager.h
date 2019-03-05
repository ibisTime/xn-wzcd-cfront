#import <Foundation/Foundation.h>
@class QNNetworkInfo;
@class QNDomain;
typedef NSArray * (^QNGetAddrInfoCallback)(NSString *host);
typedef void (^QNIpStatusCallback)(NSString *ip, int code, int ms);
@protocol QNIpSorter <NSObject>
- (NSArray *)sort:(NSArray *)ips;
@end
@interface QNDnsManager : NSObject
- (NSArray *)query:(NSString *)domain;
- (NSArray *)queryWithDomain:(QNDomain *)domain;
- (void)onNetworkChange:(QNNetworkInfo *)netInfo;
- (instancetype)init:(NSArray *)resolvers networkInfo:(QNNetworkInfo *)netInfo;
- (instancetype)init:(NSArray *)resolvers networkInfo:(QNNetworkInfo *)netInfo sorter:(id<QNIpSorter>)sorter;
- (instancetype)putHosts:(NSString *)domain ip:(NSString *)ip;
- (instancetype)putHosts:(NSString *)domain ip:(NSString *)ip provider:(int)provider;
+ (void)setGetAddrInfoBlock:(QNGetAddrInfoCallback)block;
+ (void)setDnsManagerForGetAddrInfo:(QNDnsManager *)dns;
+ (void)setIpStatusCallback:(QNIpStatusCallback)block;
+ (BOOL)needHttpDns;
@end
@interface QNDnsManager (NSURL)
- (NSURL *)queryAndReplaceWithIP:(NSURL *)url;
@end
