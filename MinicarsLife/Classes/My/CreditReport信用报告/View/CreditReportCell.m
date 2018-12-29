//
//  CreditReportCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CreditReportCell.h"

@implementation CreditReportCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 100, 16)];
        _nameLabel.font = HGfont(15);
        _nameLabel.textColor = HGColor(51, 51, 51);
    }
    return _nameLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 43, SCREEN_WIDTH - 100, 13)];
        _timeLabel.font = HGfont(13);
        _timeLabel.textColor = HGColor(153, 153, 153);
    }
    return _timeLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 85, 71)];
        _numberLabel.text = @"20";
        _numberLabel.font = HGfont(14);
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.numberLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModel:(CreditReportModel *)model
{
    _nameLabel.text = model.bizNote;
    _timeLabel.text = [model.createDatetime convertDate];
    _numberLabel.text = model.transAmountString;

}

@end
