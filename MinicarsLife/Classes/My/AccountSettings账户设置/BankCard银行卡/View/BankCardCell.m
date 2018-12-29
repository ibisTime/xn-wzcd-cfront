//
//  BankCardCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell
{
    CGFloat h;
    CGFloat w;
}

-(UIImageView *)cardImage
{
    if (!_cardImage) {
        _cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, w, h)];
        _cardImage.image = HGImage(@"通用背景");

    }
    return _cardImage;
}

-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(15 +w/5/2 - 20   , 10 +w/5/2 - 20, 40, 40)];
        _iconImage.image = HGImage(@"通用");
    }
    return _iconImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15 + w/5, 10 + h/4, SCREEN_WIDTH - 15 + w/5 - 25, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:[UIColor whiteColor]];

    }
    return _nameLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFrame:CGRectMake(15 + w/5, 10 + h/4 * 2, SCREEN_WIDTH - 15 + w/5 - 25, h/4) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(16) textColor:[UIColor whiteColor]];
    }
    return _numberLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BackColor;
        w = SCREEN_WIDTH - 30;
        h = SCREEN_WIDTH/3 - 15;
        [self addSubview:self.cardImage];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.numberLabel];
    }
    return self;
}

-(void)setModel:(BankCardModel *)model
{
    self.nameLabel.text = model.bankName;
    _numberLabel.text = [NSString stringWithFormat:@"****   ****   ****   %@",[model.bankcardNumber substringFromIndex:model.bankcardNumber.length - 4]];
}

@end
