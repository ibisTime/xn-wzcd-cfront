//
//  CarLoanCalculatorTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanCalculatorTableView.h"

#import "CarLoanCalculatorHeadCell.h"
#import "CarLoanCalculatorChooseCell.h"
#import "ApplyForView.h"

#define HeadCell @"CarLoanCalculatorHeadCell"
#define ChooseCell @"CarLoanCalculatorChooseCell"
#define ApplyFor @"ApplyForView"
@interface CarLoanCalculatorTableView ()<UITableViewDelegate,UITableViewDataSource
>
{
    NSString *stateStr;

    //    首付
    NSString *ADownPaymentStr;
    //    年限
    NSString *yearsStr;
    //    价格
    NSArray *calculatePriceArray;

    NSArray *textArray;
    NSArray *textArray1;

}
@end

@implementation CarLoanCalculatorTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CarLoanCalculatorHeadCell class] forCellReuseIdentifier:HeadCell];
        [self registerClass:[CarLoanCalculatorChooseCell class] forCellReuseIdentifier:ChooseCell];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
}

-(void)setContactArray1:(NSArray *)contactArray1
{
    textArray = contactArray1;
    [self reloadData];
}

-(void)setState:(NSString *)state
{
    stateStr = state;
    [self reloadData];
}

-(void)setNameArray:(NSArray *)nameArray
{
    ADownPaymentStr = nameArray[0];
    yearsStr = nameArray[1];
    [self reloadData];
}

-(void)setPriceArray:(NSArray *)priceArray
{
    calculatePriceArray = priceArray;
    [self reloadData];

}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CarLoanCalculatorHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.carModel = self.carModel;
        UILabel *label1 = [self viewWithTag:1000];
        UILabel *label2 = [self viewWithTag:1001];
        UILabel *label3 = [self viewWithTag:1002];
        label1.text = [NSString stringWithFormat:@"%.2f",[calculatePriceArray[0] floatValue]];
        label2.text = [NSString stringWithFormat:@"%.2f",[calculatePriceArray[1] floatValue]];
        label3.text = [NSString stringWithFormat:@"%.2f",[calculatePriceArray[2] floatValue]];
        return cell;
    }
    CarLoanCalculatorChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 1:
        {
            if ([stateStr isEqualToString:@"100"]) {
                cell.youImage.hidden = YES;
                textArray = @[[NSString stringWithFormat:@"%@",self.carModel.seriesName],[NSString stringWithFormat:@"%@",self.carModel.name]];
                cell.detailedLabel.text = textArray[indexPath.row];
            }else
            {
                cell.detailedLabel.text = textArray[indexPath.row];
                cell.youImage.hidden = NO;
            }
            NSArray *nameArray = @[@"品牌",@"型号"];
            cell.nameLabel.text = nameArray[indexPath.row];

        }
            break;
        case 2:
        {
            NSArray *nameArray = @[@"首付",@"还款年限"];
            cell.nameLabel.text = nameArray[indexPath.row];
            if ([USERXX isBlankString:ADownPaymentStr] == NO && [USERXX isBlankString:yearsStr] == NO) {
                NSArray *contactArray = @[ADownPaymentStr,yearsStr];
                cell.detailedLabel.text = contactArray[indexPath.row];
            }

        }
            break;

        default:
            break;
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 110;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        static NSString *HeaderID = ApplyFor;
        ApplyForView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
        if (footer == nil) {
            //        NSLog(@"实例化标题栏");
            footer = [[ApplyForView alloc]initWithReuseIdentifier:HeaderID];
        }
        [footer.applyForButton addTarget:self action:@selector(applyForButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        return footer;
    }
    return nil;
}

-(void)applyForButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

@end
