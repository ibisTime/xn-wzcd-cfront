//
//  RecordCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

-(UILabel *)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 155, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(16) textColor:TextColor];

    }
    return _nameLbl;
}

-(UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [UILabel labelWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 155, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];

    }
    return _timeLabel;
}

-(UILabel *)stateLabel
{
    if(!_stateLabel)
    {
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 130, 0, 100, 70) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(15) textColor:MainColor];


    }
    return _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.nameLbl];
        [self addSubview:self.timeLabel];
        [self addSubview:self.stateLabel];


        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH , 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 35 - 5.5, 6, 11)];
        youImage.image = HGImage(@"more");
        [self addSubview:youImage];
    }
    return self;
}

-(void)setModel:(ReimbursementModel *)model
{
    NSString *refType;
    if (model.refType == 0) {
        refType = @"车辆贷";
    }else
    {
        refType = @"商品贷";
    }
    _nameLbl.text = [NSString stringWithFormat:@"%@   ¥%.2f",refType,[model.loanAmount floatValue]/1000];

    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",[model.firstRepayDatetime convertDate],[model.loanEndDatetime convertDate]];
    if (model.restAmount > 0) {
        _stateLabel.text  = @"还款中";
    }
    else
    {
        _stateLabel.text  = @"已完成";
    }


//    NSDictionary *dic = model.budgetOrder;
//
//    _nameLbl.text = [NSString stringWithFormat:@"%@   ¥%.2f",,[model.loanAmount floatValue]/1000];
//
//    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",[model.firstRepayDatetime convertDate],[model.loanEndDatetime convertDate]];
//    if (model.restAmount > 0) {
//       _stateLabel.text  = @"还款中";
//    }
//    else
//    {
//        _stateLabel.text  = @"已完成";
//    }
}

-(void)setModel1:(NearFutureModel *)model1
{
    NSDictionary *repayBiz = model1.repayBiz;
    NSString *refType;
    if ([repayBiz[@"refType"] integerValue] == 0) {
        refType = @"车辆贷";
    }else
    {
        refType = @"商品贷";
    }
    _timeLabel.text = [NSString stringWithFormat:@"%@",[model1.repayDatetime convertDate]];
    _nameLbl.text = [NSString stringWithFormat:@"%@   ¥%.2f",refType,[model1.repayCapital floatValue]/1000];
    _stateLabel.text  = @"还款中";
}

-(void)setDic:(NSDictionary *)dic
{
 
}

@end
