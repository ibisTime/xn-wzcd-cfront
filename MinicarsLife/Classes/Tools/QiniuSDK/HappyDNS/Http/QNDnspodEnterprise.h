#import "QNResolverDelegate.h"
#import <Foundation/Foundation.h>
extern const int kQN_ENCRYPT_FAILED;
extern const int kQN_DECRYPT_FAILED;
@interface QNDnspodEnterprise : NSObject <QNResolverDelegate>
- (instancetype)initWithId:(NSString *)userId
                       key:(NSString *)key;
- (instancetype)initWithId:(NSString *)userId
                       key:(NSString *)key
                    server:(NSString *)server;
- (instancetype)initWithId:(NSString *)userId
                       key:(NSString *)key
                    server:(NSString *)server
                   timeout:(NSUInteger)time;
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError *__autoreleasing *)error;
@end
