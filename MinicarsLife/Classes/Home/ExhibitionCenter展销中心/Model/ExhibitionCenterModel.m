//
//  ExhibitionCenterModel.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ExhibitionCenterModel.h"

@implementation ExhibitionCenterModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"desc"]) {
        return @"description";
    }

    return propertyName;
}

- (NSArray *)pics {

    if (!_pics) {

        NSArray *imgs = [self.advPic componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics = newImgs;
    }

    return _pics;
}

@end
