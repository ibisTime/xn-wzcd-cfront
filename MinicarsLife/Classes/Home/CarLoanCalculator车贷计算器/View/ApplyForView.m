//
//  ApplyForView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ApplyForView.h"

@implementation ApplyForView

-(UILabel *)promptLable
{
    if (!_promptLable) {
        _promptLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
        _promptLable.text = @"*此结果仅供参考";
        _promptLable.textColor = GaryTextColor;
        _promptLable.textAlignment = NSTextAlignmentCenter;
        _promptLable.font = HGfont(14);
    }
    return _promptLable;
}

-(UIButton *)applyForButton
{
    if (!_applyForButton) {
        _applyForButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _applyForButton.frame = CGRectMake(20, 45, SCREEN_WIDTH - 40, 50);
        [_applyForButton setTitle:@"申请分期购车" forState:(UIControlStateNormal)];
        _applyForButton.titleLabel.font = HGfont(14);
        _applyForButton.backgroundColor = MainColor;
        _applyForButton.layer.masksToBounds = YES;
        _applyForButton.layer.cornerRadius = 5;
    }
    return _applyForButton;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.promptLable];
        [self addSubview:self.applyForButton];
    }
    return self;
}

@end
