//
//  MyCarLoanDetailsTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MyCarLoanDetailsTableView.h"
#import "MyCarLoanDetailsPriceCell.h"
#import "MyCarLoanNameCell.h"
#import "ApplyForView.h"
#define MyCarLoanDetailsPrice @"MyCarLoanDetailsPriceCell"
#define MyCarLoanName @"MyCarLoanNameCell"
@interface MyCarLoanDetailsTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *priceAry;
}

@end

@implementation MyCarLoanDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyCarLoanDetailsPriceCell class] forCellReuseIdentifier:MyCarLoanDetailsPrice];
        [self registerClass:[MyCarLoanNameCell class] forCellReuseIdentifier:MyCarLoanName];
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

-(void)setPriceArray:(NSArray *)priceArray
{
    priceAry = priceArray;
    [self reloadData];
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyCarLoanDetailsPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCarLoanDetailsPrice forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        if (priceAry.count > 0) {
            cell.array = priceAry;
        }
        return cell;
    }
    MyCarLoanNameCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCarLoanName forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 1:
        {
            NSArray *nameArray = @[@"品牌",@"型号"];
            cell.nameLabel.text = nameArray[indexPath.row];
            NSArray *contactArray = @[_model.seriesName,_model.carName];
            cell.detailedLabel.text = contactArray[indexPath.row];
        }
            break;
        case 2:
        {
            NSArray *nameArray = @[@"首付",@"还款年限"];
            cell.nameLabel.text = nameArray[indexPath.row];
            NSString *str = @"%";
            NSArray *contactArray = @[[NSString stringWithFormat:@"%.1f%@",_model.sfRate * 100,str],[NSString stringWithFormat:@"%ld年",[_model.periods integerValue]/12]];
            cell.detailedLabel.text = contactArray[indexPath.row];
        }
            break;

        default:
            break;
    }
    return cell;
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
        static NSString *HeaderID = @"ApplyFor";
        ApplyForView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
        if (footer == nil) {
            //        NSLog(@"实例化标题栏");
            footer = [[ApplyForView alloc]initWithReuseIdentifier:HeaderID];
        }
        footer.applyForButton.hidden = YES;
        return footer;
    }
    return nil;
}


@end
