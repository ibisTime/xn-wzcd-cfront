//
//  TheDetailCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheDetailCell.h"

@implementation TheDetailCell

-(UILabel *)dayLbl
{
    if (!_dayLbl) {
        _dayLbl = [UILabel labelWithFrame:CGRectMake(15, 15, 50, 36) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(18) textColor:TextColor];
        _dayLbl.text = @"15日";
        _dayLbl.numberOfLines = 2;
    }
    return _dayLbl;
}

-(UILabel *)whenLbl
{
    if (!_whenLbl) {
        _whenLbl = [UILabel labelWithFrame:CGRectMake(15, 40, 50, 16) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
//        _whenLbl.text = @"21:46";
    }
    return _whenLbl;
}

-(UIImageView *)stateImg
{
    if (!_stateImg) {
        _stateImg = [[UIImageView alloc]initWithFrame:CGRectMake(80, 17.5, 36, 36)];
        _stateImg.image = HGImage(@"支");
    }
    return _stateImg;
}

-(UILabel *)moneyLbl
{
    if (!_moneyLbl) {
        _moneyLbl = [UILabel labelWithFrame:CGRectMake(140, 15, SCREEN_WIDTH - 150, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:MoneyColor];
        _moneyLbl.text = @"+2.00";
    }
    return _moneyLbl;
}

-(UILabel *)useLbl
{
    if (!_useLbl) {
        _useLbl = [UILabel labelWithFrame:CGRectMake(140, 40, SCREEN_WIDTH - 150, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
        _useLbl.text = @"[公益消费收益] 分红权I123345";
    }
    return _useLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.dayLbl];
        [self addSubview:self.whenLbl];
        [self addSubview:self.stateImg];
        [self addSubview:self.moneyLbl];
        [self addSubview:self.useLbl];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

    }
    return self;
}

-(void)setModel:(TheDetailModel *)model
{
    _dayLbl.text = [model.adjustDatetime convertDate];
    if ([model.transAmount floatValue]/1000 >=0) {
        _stateImg.image = HGImage(@"收");
    }else
    {
        _stateImg.image = HGImage(@"支");
    }
    _moneyLbl.text = [NSString stringWithFormat:@"%.2f",[model.transAmount floatValue]/1000];
    _useLbl.text = model.adjustNote;
}



@end
