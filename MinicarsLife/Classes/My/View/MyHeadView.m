//
//  MyHeadView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, kStatusBarHeight + 55, 60, 60)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = 30;
        _headImage.image = HGImage(@"myheadimage");

        NSLog(@"%@",[[USERDEFAULTS objectForKey:PHOTO] convertImageUrl]);
    }
    return _headImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(80 , kStatusBarHeight + 60, SCREEN_WIDTH - 110, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(20) textColor:[UIColor whiteColor]];
        
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 , kStatusBarHeight + 90, SCREEN_WIDTH - 110, 20)];
        _phoneLabel.font = HGfont(13);
        _phoneLabel.textColor = [UIColor whiteColor];
        
    }
    return _phoneLabel;
}

-(UIButton *)balanceButton
{
    if (!_balanceButton) {
        _balanceButton = [UIButton buttonWithTitle:@"账户余额:0.00" titleColor:[UIColor whiteColor] backgroundColor:kClearColor titleFont:14];
        _balanceButton.frame = CGRectMake(0, self.frame.size.height - 25, SCREEN_WIDTH/2, 20);
        [_balanceButton addTarget:self action:@selector(ButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _balanceButton.tag = 100;
        
    }
    return _balanceButton;
}

-(UIButton *)integralButton
{
    if (!_integralButton) {
        _integralButton = [UIButton buttonWithTitle:@"账户积分:0.00" titleColor:[UIColor whiteColor] backgroundColor:kClearColor titleFont:14];
        _integralButton.frame = CGRectMake(SCREEN_WIDTH/2, self.frame.size.height - 25, SCREEN_WIDTH/2, 20);
        [_integralButton addTarget:self action:@selector(ButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _integralButton.tag = 101;
        
    }
    return _integralButton;
}

-(void)ButtonClick:(UIButton *)sender
{
    [_delegate MyHeadButton:sender.tag - 100];
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170 + kStatusBarHeight)];
        _backImage.image = HGImage(@"myback");
        [self addSubview:_backImage];

        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];

        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20, kStatusBarHeight + 60 + 19.5, 6, 11)];
        youImage.image = HGImage(@"whiteYOU");
        [self addSubview:youImage];

        [self addSubview:self.balanceButton];
        [self addSubview:self.integralButton];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.frame.size.height - 25, 1, 20)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];

        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, kStatusBarHeight + 60, SCREEN_WIDTH, 50);
        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 102;
        [self addSubview:button];


    }
    return self;
}

@end
