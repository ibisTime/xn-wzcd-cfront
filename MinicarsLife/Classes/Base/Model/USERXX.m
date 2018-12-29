//
//  USERXX.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "USERXX.h"

@implementation USERXX


+ (instancetype)user{

    static USERXX *user = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        user = [[USERXX alloc] init];

    });

    return user;
}

- (void)setToken:(NSString *)token {

    _token = [token copy];
    [USERDEFAULTS objectForKey:TOKEN_ID];
    [USERDEFAULTS synchronize];
}

- (void)setUserId:(NSString *)userId {

    _userId = [userId copy];
    [USERDEFAULTS objectForKey:USER_ID];
    [USERDEFAULTS synchronize];
}

-(void)setNickname:(NSString *)nickname
{
    _nickname = [nickname copy];
    [USERDEFAULTS objectForKey:NICKNAME];
    [USERDEFAULTS synchronize];
}

-(void)setMobile:(NSString *)mobile
{
    _mobile = [mobile copy];
    [USERDEFAULTS objectForKey:MOBILE];
    [USERDEFAULTS synchronize];
}

- (BOOL)isLogin {
    NSString *userId = [USERDEFAULTS objectForKey:USER_ID];
    NSString *token = [USERDEFAULTS objectForKey:TOKEN_ID];
    NSLog(@"%@===%@",userId,token);
    if ([USERXX isBlankString:userId] == NO && [USERXX isBlankString:token] == NO) {

        self.userId = userId;
        self.token = token;

        return YES;
    } else {

        return NO;
    }
}

- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];

    [http postWithSuccess:^(id responseObject) {

        [self setUserInfoWithDict:responseObject[@"data"]];

//        [self saveUserInfo:responseObject[@"data"]];
    } failure:^(NSError *error) {

    }];



}

- (void)setUserInfoWithDict:(NSDictionary *)dict {
    [USERDEFAULTS setObject:dict[@"mobile"] forKey:MOBILE];
    [USERDEFAULTS setObject:dict[@"nickname"] forKey:NICKNAME];
    [USERDEFAULTS setObject:dict[@"photo"] forKey:PHOTO];
    [USERDEFAULTS setObject:dict[@"tradepwdFlag"] forKey:PAYPASSWORD];
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }

    return NO;
}

@end
