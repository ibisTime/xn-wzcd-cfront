//
//  CustomTextFieldView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CustomTextFieldView.h"

@implementation CustomTextFieldView

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
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 130, 60)];
        _nameTextField.font = HGfont(14);
        [_nameTextField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    }
    return _nameTextField;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextField];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

    }
    return self;
}

@end
