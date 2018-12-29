//
//  CarLoanCalculatorModel.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanCalculatorModel.h"

@implementation CarLoanCalculatorModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"CarId"]) {
        return @"id";
    }

    return propertyName;
}

@end
