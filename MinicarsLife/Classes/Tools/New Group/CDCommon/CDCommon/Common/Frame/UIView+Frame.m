//
//  UIView+Frame.m
//  OMMO
//
//  Created by 田磊 on 16/4/3.
//  Copyright © 2016年 OMMO. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark- y,yy,x,xx
-(void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

-(CGFloat)y {
    return self.frame.origin.y;
    
}

- (CGFloat)xx
{
    return  self.x + self.width;
    
}


- (void)setXx:(CGFloat)xx
{
    
    CGFloat w  = xx - self.x;
    self.width = w;
    
}

- (CGFloat)yy
{
    return  self.y + self.height;
    
}

- (void)setYy:(CGFloat)yy
{
    
    CGFloat h  = yy - self.y;
    self.height = h;
    
    
    
}



#pragma mark- width,height
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
    
}

- (CGFloat)height
{
    return self.frame.size.height;
    
}


#pragma mark- size,origin,center
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}



- (void)setYy_size:(CGFloat)yy_size {

        CGFloat cha = yy_size - self.yy;
        self.y = self.y + cha;
    
}

- (CGFloat)yy_size{

    return self.yy;
}

- (void)setXx_size:(CGFloat)xx_size {

    CGFloat cha = xx_size - self.xx;
    self.x = self.x + cha;
}

- (CGFloat)xx_size {

    return self.xx;

}

#pragma mark- top,bottom,left,right
- (CGFloat)top {
    
    return self.origin.y;
    
}

- (CGFloat)bottom {
    
    return self.origin.y + self.size.height;
}


- (CGFloat)left {

    return self.origin.x;
}

- (CGFloat)right {

    return self.origin.x + self.size.width;
}


- (void)setTop:(CGFloat)top {

    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;

}

- (void)setBottom:(CGFloat)bottom {

    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
    
}

- (void)setLeft:(CGFloat)left {

    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {

    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
    
}



@end
