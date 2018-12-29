//
//  PayAllPriceCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PayAllPriceCell.h"

@implementation PayAllPriceCell

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2 - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];
        _nameLbl.text = @"支付金额";

    }
    return _nameLbl;
}

-(UILabel *)priceLbl
{
    if(!_priceLbl)
    {
        _priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 15, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:HGColor(252, 125, 65)];
        _priceLbl.text = @"支付金额";

    }
    return _priceLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.nameLbl];
        [self addSubview:self.priceLbl];
    }
    return self;
}

@end
