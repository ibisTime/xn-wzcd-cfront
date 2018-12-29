//
//  MessageModel.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"ID"]) {
        return @"id";
    }

    return propertyName;
}

@end
