//
//  RecordDetailsHeadCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordDetailsHeadCell.h"

@implementation RecordDetailsHeadCell
{
    UILabel *nameLabel;
    UILabel *numberLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        nameLabel = [UILabel labelWithFrame:CGRectMake(0, 36.5, SCREEN_WIDTH, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(15) textColor:HGColor(72, 72, 72)];

        [self addSubview:nameLabel];

        numberLabel = [UILabel labelWithFrame:CGRectMake(0, 41.5+25, SCREEN_WIDTH, 32) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(32) textColor:HGColor(252, 125, 65)];

        [self addSubview:numberLabel];
    }
    return self;
}

-(void)setModel:(ReimbursementModel *)model
{
    numberLabel.text =  [NSString stringWithFormat:@"%.2f",model.restAmount/1000];
    nameLabel.text = @"欠款总额(元)";
}

-(void)setModel1:(NearFutureModel *)model1
{

    nameLabel.text = @"应还总额(元)";
    NSDictionary *repayBiz = model1.repayBiz;
    numberLabel.text =  [NSString stringWithFormat:@"%.2f",[model1.repayCapital floatValue]/1000];
}

@end
