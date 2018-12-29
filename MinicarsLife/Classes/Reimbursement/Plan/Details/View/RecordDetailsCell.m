//
//  RecordDetailsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordDetailsCell.h"

@implementation RecordDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        NSArray *nameArray = @[@"贷款信息",@"贷款车辆",@"欠款总额",@"贷款期限",@"还款卡号",@"贷款状态"];
//        NSArray *detailsArray = @[@"",@"奥迪A7",@"30万",@"2018-02-02至2028-02-02",@"522200 2342112341 123",@"还款中"];
        for (int i = 0; i < 6; i ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 14 + i % 6 * 35, 85, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            nameLabel.text = nameArray[i];
            nameLabel.tag = 10000 + i;
            [self addSubview:nameLabel];

            UILabel *detailsLbl = [UILabel labelWithFrame:CGRectMake(100, 14 + i % 6 * 35, SCREEN_WIDTH - 115, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            detailsLbl.tag = 1000 + i;
            if (i == 5) {
                detailsLbl.textColor = MainColor;
            }
            [self addSubview:detailsLbl];

        }
    }
    return self;
}

-(void)setModel:(ReimbursementModel *)model
{
    UILabel *label = [self viewWithTag:10001];
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    UILabel *label5 = [self viewWithTag:1004];
    UILabel *label6 = [self viewWithTag:1005];
    NSDictionary *dic;
    if (model.refType == 0) {
        label.text = @"贷款车辆";
        dic = model.budgetOrder;
        label2.text = dic[@"carBrand"];
        label3.text =  [NSString stringWithFormat:@"%.2f",[dic[@"loanAmount"] floatValue]/1000];
        label4.text = dic[@"loanPeriod"];
        label5.text = dic[@"repayBankcardNumber"];

    }else
    {
        label.text = @"贷款商品";
        dic = model.mallOrder;
        label2.text = [NSString stringWithFormat:@"%@",dic[@"productOrderList"][0][@"product"][@"name"]];
        label3.text = [NSString stringWithFormat:@"%.2f",[dic[@"loanAmount"] floatValue]/1000];
        label4.text = [NSString stringWithFormat:@"%@",dic[@"periods"]];
        label5.text = [NSString stringWithFormat:@"%@",dic[@"bankcardNumber"]];
    }
}

-(void)setModel1:(NearFutureModel *)model1
{

    NSDictionary *repayBiz = model1.repayBiz;
    UILabel *label = [self viewWithTag:10001];
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    UILabel *label5 = [self viewWithTag:1004];
    UILabel *label6 = [self viewWithTag:1005];


    if ([repayBiz[@"refType"] integerValue] == 0) {
        label.text = @"贷款车辆";
    }else
    {
        label.text = @"贷款商品";
    }

    label3.text =  [NSString stringWithFormat:@"%.2f",[repayBiz[@"monthAmount"] floatValue]/1000];
    label4.text = [NSString stringWithFormat:@"%@",repayBiz[@"periods"]];
//
//    label6.text  = @"待还款";
}

-(void)setDic:(NSDictionary *)dic
{
    NSLog(@"%@",dic[@"repayBiz"]);
//    NSDictionary *repayBiz = dic[@"repayBiz"];
//    UILabel *label = [self viewWithTag:10001];
//    UILabel *label1 = [self viewWithTag:1000];
//    UILabel *label2 = [self viewWithTag:1001];
//    UILabel *label3 = [self viewWithTag:1002];
//    UILabel *label4 = [self viewWithTag:1003];
//    UILabel *label5 = [self viewWithTag:1004];
//    UILabel *label6 = [self viewWithTag:1005];
//
//
//    if ([repayBiz[@"refType"] integerValue] == 0) {
//        label.text = @"贷款车辆";
//    }else
//    {
//        label.text = @"贷款商品";
//    }
//    label2.text = [NSString stringWithFormat:@"%@",]
//    label3.text =  [NSString stringWithFormat:@"%.2f",[repayBiz[@"monthAmount"] floatValue]/1000];
//    label4.text = [NSString stringWithFormat:@"%@",repayBiz[@"periods"]];
//    label5.text = [NSString stringWithFormat:@"%@",dic[@"bankcardNumber"]];

    UILabel *label = [self viewWithTag:10001];
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    UILabel *label5 = [self viewWithTag:1004];
    UILabel *label6 = [self viewWithTag:1005];
    NSDictionary *dic1;
    if ([dic[@"refType"] integerValue] == 0) {
        label.text = @"贷款车辆";
        dic1 = dic[@"repayBiz"][@"budgetOrder"];
        label2.text = dic1[@"carBrand"];
        label3.text = [NSString stringWithFormat:@"%.2f",[dic1[@"loanAmount"] floatValue]/1000];
        label4.text = dic1[@"loanPeriod"];
        label5.text = dic1[@"repayBankcardNumber"];
        NSLog(@"%@",dic1[@"carBrand"]);

    }else
    {
        label.text = @"贷款商品";
        dic1 = dic[@"mallOrder"];
        label2.text = [NSString stringWithFormat:@"%@",dic1[@"productOrderList"][0][@"product"][@"name"]];
        label3.text = [NSString stringWithFormat:@"%.2f",[dic1[@"loanAmount"] floatValue]/1000];
        label4.text = [NSString stringWithFormat:@"%@",dic1[@"periods"]];
        label5.text = [NSString stringWithFormat:@"%@",dic1[@"bankcardNumber"]];
    }

}

@end
