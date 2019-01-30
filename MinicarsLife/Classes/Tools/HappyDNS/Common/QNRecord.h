#import <Foundation/Foundation.h>
extern const int kQNTypeA;
extern const int kQNTypeAAAA;
extern const int kQNTypeCname;
extern const int kQNTypeTXT;
@interface QNRecord : NSObject
@property (nonatomic, strong, readonly) NSString *value;
@property (nonatomic, readonly) int ttl;
@property (nonatomic, readonly) int type;
@property (nonatomic, readonly) long long timeStamp;
- (instancetype)init:(NSString *)value
                 ttl:(int)ttl
                type:(int)type;
- (BOOL)expired:(long long)time;
@end
