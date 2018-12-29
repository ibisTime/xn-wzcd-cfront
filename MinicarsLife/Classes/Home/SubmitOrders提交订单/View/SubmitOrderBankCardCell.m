//
//  SubmitOrderBankCardCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrderBankCardCell.h"

@implementation SubmitOrderBankCardCell
{
    UIImageView *youImage;
}

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, 80, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];

    }
    return _nameLbl;
}

-(UILabel *)cardholderLbl
{
    if(!_cardholderLbl)
    {
        _cardholderLbl = [UILabel labelWithFrame:CGRectMake(95, 15, SCREEN_WIDTH - 135, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
    }
    return _cardholderLbl;
}

-(UILabel *)accountNameLbl
{
    if(!_accountNameLbl)
    {
        _accountNameLbl = [UILabel labelWithFrame:CGRectMake(95, 40, SCREEN_WIDTH - 135, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
    }
    return _accountNameLbl;
}

-(UILabel *)cardNumberLbl
{
    if(!_cardNumberLbl)
    {
        _cardNumberLbl = [UILabel labelWithFrame:CGRectMake(95, 65, SCREEN_WIDTH - 135, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];

    }
    return _cardNumberLbl;
}

-(UILabel *)backLabel
{
    if (!_backLabel) {
        _backLabel = [UILabel labelWithFrame:CGRectMake(40,0, SCREEN_WIDTH - 80 , 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _backLabel.text = @"请选择银行卡";
    }
    return _backLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.nameLbl];
        [self addSubview:self.cardholderLbl];
        [self addSubview:self.accountNameLbl];
        [self addSubview:self.cardNumberLbl];
        [self addSubview:self.backLabel];

        youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 22.5, 50/2 - 5.5, 6, 11)];
        youImage.image = HGImage(@"more");
        [self addSubview:youImage];

    }
    return self;
}

-(void)setModel:(BankCardModel *)model
{
    youImage.frame = CGRectMake(SCREEN_WIDTH - 22.5, 95/2 - 5.5, 6, 11);
    _nameLbl.text = @"还款银行卡:";
    _cardholderLbl.text = [NSString stringWithFormat:@"持卡人:%@",model.realName];
    _accountNameLbl.text = [NSString stringWithFormat:@"开户行:%@",model.bankName];
    _cardNumberLbl.text = [NSString stringWithFormat:@"卡    号:尾数%@",[model.bankcardNumber substringFromIndex:model.bankcardNumber.length - 4]];
}

@end
