//
//  TermsOfServiceView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TermsOfServiceView.h"

@implementation TermsOfServiceView

-(UIButton *)chooseButton
{
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithTitle:@"我已阅读并同意" titleColor:GaryTextColor backgroundColor:self.backgroundColor titleFont:14 cornerRadius:0];
        _chooseButton.frame = CGRectMake(15, 0, 115, 20);
        [_chooseButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"tick-uncheck"] forState:(UIControlStateNormal)];
            [button setImage:[UIImage imageNamed:@"tick-Select"] forState:(UIControlStateSelected)];
        }];
        

    }
    return _chooseButton;
}

-(UIButton *)termsOfServiceButton
{
    if (!_termsOfServiceButton) {
        _termsOfServiceButton = [UIButton buttonWithTitle:@"《服务条款》" titleColor:MainColor backgroundColor:self.backgroundColor titleFont:15 cornerRadius:0];
        _termsOfServiceButton.frame = CGRectMake(_chooseButton.frame.origin.x + _chooseButton.frame.size.width, 0, 100, 20);
        _termsOfServiceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _termsOfServiceButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.chooseButton];
        [self addSubview:self.termsOfServiceButton];
    }
    return self;
}



@end
