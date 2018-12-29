//
//  UIScrollView+TLAdd.m
//  CustomB
//
//  Created by  tianlei on 2017/9/22.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "UIScrollView+TLAdd.h"

#define  adjustsContentInsets(scrollView)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
}\
_Pragma("clang diagnostic pop") \
} while (0)

@implementation UIScrollView (TLAdd)


- (void)adjustsContentInsets {
    
    if (!self || ![self isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    adjustsContentInsets(self);
    
}


@end
