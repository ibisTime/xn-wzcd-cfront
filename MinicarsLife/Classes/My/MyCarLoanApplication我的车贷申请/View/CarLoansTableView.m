//
//  CarLoansTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoansTableView.h"

#import "CarLoanApplicationCell.h"

#define CarLoanApplication @"CarLoanApplicationCell"

@interface CarLoansTableView ()<UITableViewDelegate,UITableViewDataSource
>


@end

@implementation CarLoansTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CarLoanApplicationCell class] forCellReuseIdentifier:CarLoanApplication];
    }

    return self;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarLoanApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:CarLoanApplication forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.model.count > 0) {
        cell.model = self.model[indexPath.row];
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
    return 140;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
