//
//  SendCodeView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SendCodeView.h"

@implementation SendCodeView

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 60)];
        _nameLabel.font = HGfont(14);
    }
    return _nameLabel;
}

-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 230, 60)];
        _nameTextField.font = HGfont(14);
        [_nameTextField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    }
    return _nameTextField;
}

-(UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sendButton.frame = CGRectMake(SCREEN_WIDTH - 100, 15, 80, 30);
        [_sendButton setTitle:@"发送验证码" forState:(UIControlStateNormal)];
        _sendButton.backgroundColor = MainColor;
        kViewRadius(_sendButton, 5);
        _sendButton.titleLabel.font = HGfont(12);

    }
    return _sendButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextField];
        [self addSubview:self.sendButton];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

@end
