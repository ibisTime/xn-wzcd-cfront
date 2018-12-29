//
//  UIView+Frame.h
//  OMMO
//
//  Created by 田磊 on 16/4/3.
//  Copyright © 2016年 OMMO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//效果相同
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat left;

//
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat top;

//
@property (nonatomic, assign) CGFloat xx;
@property (nonatomic, assign) CGFloat right;

//
@property (nonatomic, assign) CGFloat yy;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;



@end
