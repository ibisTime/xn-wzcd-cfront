//
//  TheBalanceOfCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheBalanceOfCell.h"

@implementation TheBalanceOfCell

-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2 - 15, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];

    }
    return _nameLbl;
}

-(UILabel *)moneyLbl
{
    if (!_moneyLbl) {
        _moneyLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 15, 60) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];

    }
    return _moneyLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.moneyLbl];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModel:(AccountModel *)model
{
    
}

@end
