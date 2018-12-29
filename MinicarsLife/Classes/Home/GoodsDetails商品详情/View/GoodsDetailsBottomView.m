//
//  GoodsDetailsBottomView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GoodsDetailsBottomView.h"

@implementation GoodsDetailsBottomView

-(UILabel *)MonthlyPaymentsLabel
{
    if (!_MonthlyPaymentsLabel) {
        _MonthlyPaymentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, SCREEN_WIDTH - 120, 49)];
        _MonthlyPaymentsLabel.font = HGfont(14);


    }
    return _MonthlyPaymentsLabel;
}

-(UIButton *)shoppingButton
{
    if (!_shoppingButton) {
        _shoppingButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shoppingButton.frame = CGRectMake(SCREEN_WIDTH - 100, 1, 100, 49);
        [_shoppingButton setTitle:@"分期购买" forState:(UIControlStateNormal)];
        _shoppingButton.titleLabel.font = HGfont(13);
        _shoppingButton.backgroundColor = MainColor;

    }
    return _shoppingButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];
        [self addSubview:self.MonthlyPaymentsLabel];
        [self addSubview:self.shoppingButton];
    }
    return self;
}

-(void)setTextDic:(NSDictionary *)textDic
{
    NSString *str = [NSString stringWithFormat:@"月供: %.2fx%@期",[textDic[@"monthAmount"] floatValue]/1000,textDic[@"periods"]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:GaryTextColor
                    range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MainColor
                    range:NSMakeRange(3, str.length - 3)];
    _MonthlyPaymentsLabel.attributedText = attrStr;
}


@end
