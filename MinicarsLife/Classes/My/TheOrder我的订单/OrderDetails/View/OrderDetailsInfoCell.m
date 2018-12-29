//
//  OrderDetailsInfoCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "OrderDetailsInfoCell.h"

@implementation OrderDetailsInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *theTitleLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];
        theTitleLabel.text = @"订单信息";
        [self addSubview:theTitleLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

        for (int i = 0; i < 3; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 50 + i % 3 * 30, SCREEN_WIDTH - 25, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _nameLabel.tag = 100 + i;
            [self addSubview:_nameLabel];
        }

    }
    return self;
}

-(void)setModel:(OrderModel *)model
{
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    label1.text = [NSString stringWithFormat:@"订  单  号:%@",model.code];
    label2.text = [NSString stringWithFormat:@"下单时间:%@",[model.updateDatetime convertDate]];
    if ([model.status isEqualToString:@"1"]) {
        label3.text = @"待支付";
    }else if ([model.status isEqualToString:@"2"])
    {
        label3.text = @"待发货";
    }else if ([model.status isEqualToString:@"3"])
    {
        label3.text = @"已发货";
    }else if ([model.status isEqualToString:@"4"])
    {
        label3.text = @"已收货";
    }else
    {
        label3.text = @"已取消";
    }
}

@end
