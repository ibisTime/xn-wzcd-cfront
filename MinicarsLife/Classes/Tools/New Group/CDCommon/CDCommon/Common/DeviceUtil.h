//
//  DeviceUtil.h
//  CustomB
//
//  Created by  tianlei on 2017/9/22.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DeviceUtil : NSObject

@property (nonatomic, assign,class,readonly) CGFloat statusBarHeight;
@property (nonatomic, assign,class,readonly) CGFloat bottomInsetHeight;

+ (CGFloat)top64;
+ (CGFloat)bottom49;

@end
