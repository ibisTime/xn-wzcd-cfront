//
//  CarLoanCalculatorChooseCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanCalculatorChooseCell.h"

@implementation CarLoanCalculatorChooseCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
        _nameLabel.font = HGfont(14);

    }
    return _nameLabel;
}

-(UILabel *)detailedLabel
{
    if (!_detailedLabel) {
        _detailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 140, 50)];
        _detailedLabel.font = HGfont(15);
    }
    return _detailedLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailedLabel];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH - 20, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

        _youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 26, 19.5, 6, 11)];
        _youImage.image = HGImage(@"more");
        [self addSubview:_youImage];

    }
    return self;
}

@end
