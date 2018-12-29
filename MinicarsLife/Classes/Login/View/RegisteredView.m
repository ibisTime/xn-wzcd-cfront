//
//  RegisteredView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RegisteredView.h"

@implementation RegisteredView


-(UILabel *)Registered_Label
{
    if (!_Registered_Label) {
        _Registered_Label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 50)];
        _Registered_Label.font = HGfont(16);

    }
    return _Registered_Label;
}

-(UITextField *)Registered_TextField
{
    if (!_Registered_TextField) {
        _Registered_TextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH - 120, 50)];
        _Registered_TextField.font = HGfont(16);
        [_Registered_TextField setValue:HGfont(16) forKeyPath:@"_placeholderLabel.font"];
    }
    return _Registered_TextField;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.Registered_Label];
        [self addSubview:self.Registered_TextField];
    }
    return self;
}

@end
