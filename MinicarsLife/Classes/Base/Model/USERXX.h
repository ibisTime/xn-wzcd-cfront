//
//  USERXX.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USERXX : NSObject

+ (instancetype)user;

@property (nonatomic , copy)NSString *token;

@property (nonatomic , copy)NSString *userId;

@property (nonatomic , copy)NSString *photo;

@property (nonatomic , copy)NSString *loginName;

@property (nonatomic , copy)NSString *mobile;

@property (nonatomic , copy)NSString *nickname;

//是否为需要登录，如果已登录，取出用户信息
- (BOOL)isLogin;
//字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;

//存储用户信息
- (void)saveUserInfo:(NSDictionary *)userInfo;

- (void)updateUserInfoWithNotification;

@end
