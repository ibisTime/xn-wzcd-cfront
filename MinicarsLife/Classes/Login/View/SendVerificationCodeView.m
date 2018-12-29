//
//  SendVerificationCodeView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SendVerificationCodeView.h"

@implementation SendVerificationCodeView

-(UILabel *)code_Label
{
    if (!_code_Label) {
        _code_Label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 50)];
        _code_Label.font = HGfont(16);
        _code_Label.text = @"验证码";
    }
    return _code_Label;
}

-(UITextField *)code_TextField
{
    if (!_code_TextField) {
        _code_TextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH - 210, 50)];
        _code_TextField.font = HGfont(16);
        _code_TextField.placeholder = @"请输入验证码";
        [_code_TextField setValue:HGfont(16) forKeyPath:@"_placeholderLabel.font"];
    }
    return _code_TextField;
}

-(UIButton *)code_Button
{
    if (!_code_Button) {
        _code_Button = [UIButton buttonWithTitle:@"获取验证码" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:12 cornerRadius:5];
        _code_Button.frame = CGRectMake(SCREEN_WIDTH - 95, 10, 80, 30);
    }
    return _code_Button;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.code_Label];
        [self addSubview:self.code_TextField];
        [self addSubview:self.code_Button];
    }
    return self;
}

@end
