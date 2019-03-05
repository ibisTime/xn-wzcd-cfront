#import "QNResolverDelegate.h"
#import <Foundation/Foundation.h>
@interface QNNiuDns : NSObject <QNResolverDelegate>
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError *__autoreleasing *)error;
@property (nonatomic, strong, readonly) NSString *accountId;
@property (nonatomic, strong, readonly) NSString *encryptKey;
@property (nonatomic, assign, readonly) long expireTime;
@property (nonatomic, assign, readonly) BOOL isHttps;
@property (nonatomic, assign, readonly) BOOL isNeedEncrypted;
- (instancetype)initWithAccountId:(NSString *)accountId
                       encryptKey:(NSString *)encryptKey
                       expireTime:(long)expireTime
                          isHttps:(BOOL)isHttps
                  isNeedEncrypted:(BOOL)isNeedEncrypted;
@end
