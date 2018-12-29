//
//  RepaymentPlanCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanCell.h"

@implementation RepaymentPlanCell

-(UILabel *)numberLbl
{
    if (!_numberLbl) {
        _numberLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH/2 - 15, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(16) textColor:TextColor];
    }
    return _numberLbl;
}

-(UILabel *)priceLbl
{
    if (!_priceLbl) {
        _priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 15, SCREEN_WIDTH/2 - 15, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(16) textColor:TextColor];
    }
    return _priceLbl;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectMake(15, 40, SCREEN_WIDTH/2 - 15, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
    }
    return _timeLabel;

}

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, SCREEN_WIDTH/2 - 15, 12) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
    }
    return _stateLabel;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

        [self addSubview:self.numberLbl];
        [self addSubview:self.priceLbl];
        [self addSubview:self.timeLabel];
        [self addSubview:self.stateLabel];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 62 + 15, SCREEN_WIDTH - 30, 3)];
        backView.backgroundColor = BackColor;
        kViewRadius(backView, 1.5);
        [self addSubview:backView];

        _progressBarView = [[UIView alloc]init];
        _progressBarView.backgroundColor = MainColor;
        kViewRadius(_progressBarView, 1.5);
        [self addSubview:_progressBarView];


    }
    return self;
}

-(void)setDic:(NSDictionary *)dic
{
    _numberLbl.text = [NSString stringWithFormat:@"%@/%@期",dic[@"curPeriods"],dic[@"periods"]];
    _priceLbl.text = [NSString stringWithFormat:@"%.2f",[dic[@"repayCapital"] floatValue]/1000];
    _timeLabel.text = [dic[@"repayDatetime"] convertDate];
    if ([dic[@"repayAmount"] floatValue] == [dic[@"payedAmount"] floatValue]) {
        _stateLabel.text = @"已还款";
        _stateLabel.textColor = MainColor;
    }else{
        _stateLabel.text = @"未还";
        _stateLabel.textColor = GaryTextColor;
    }
    _progressBarView.frame = CGRectMake(15, 76, (SCREEN_WIDTH - 30)*[dic[@"repayCapital"] floatValue]/[dic[@"payedAmount"] floatValue], 4);

    if ([dic[@"curNodeCode"] isEqualToString:@"004_01"]) {
        if ([dic[@"payedAmount"] integerValue] == 0) {
            _stateLabel.text = @"未还";
            _stateLabel.textColor = GaryTextColor;
        }else
        {
            _stateLabel.text = @"已还款";
            _stateLabel.textColor = MainColor;
        }
    }else if ([dic[@"curNodeCode"] isEqualToString:@"004_02"])
    {

        _progressBarView.frame = CGRectMake(15, 76, (SCREEN_WIDTH - 30), 4);
        _stateLabel.text = @"已还款";
        _stateLabel.textColor = MainColor;
    }else if ([dic[@"curNodeCode"] isEqualToString:@"004_06"])
    {
        _stateLabel.text = @"预期";
        _stateLabel.textColor = [UIColor redColor];
    }

}

@end
