//
//  RepaymentPlanHeadCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanHeadCell.h"

@implementation RepaymentPlanHeadCell
{
    UILabel *nameLabel;
    UILabel *numberLabel;
    UILabel *promptLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        nameLabel = [UILabel labelWithFrame:CGRectMake(0, 36.5, SCREEN_WIDTH, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(15) textColor:HGColor(72, 72, 72)];
        nameLabel.text = @"剩余还款总额";
        [self addSubview:nameLabel];

        numberLabel = [UILabel labelWithFrame:CGRectMake(0, 36.5 + 30, SCREEN_WIDTH, 32) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(32) textColor:HGColor(252, 125, 65)];
        [self addSubview:numberLabel];

        promptLabel = [UILabel labelWithFrame:CGRectMake(0, 36.5 + 30 + 10 + 37, SCREEN_WIDTH, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];

        [self addSubview:promptLabel];

    }
    return self;
}

-(void)setModel:(ReimbursementModel *)model
{
    numberLabel.text =  [NSString stringWithFormat:@"%.2f",model.restAmount/1000];
    promptLabel.text = [NSString stringWithFormat:@"(包含利息及费用%.2f元)",model.restAmount/1000];
}

@end
