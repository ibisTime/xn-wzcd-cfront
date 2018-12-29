//
//  OrderTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "OrderTableView.h"
#import "OrderCell.h"
#define Order @"OrderCell"
@interface OrderTableView ()<UITableViewDelegate,UITableViewDataSource
>
@end
@implementation OrderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[OrderCell class] forCellReuseIdentifier:Order];
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
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:Order forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.model = self.model[indexPath.row];
    }

    [cell.cancelButton addTarget:self action:@selector(button1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.cancelButton.tag = indexPath.row;
    [cell.ContinueButton addTarget:self action:@selector(button2Click:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.ContinueButton.tag = indexPath.row;

    return cell;

}

-(void)button1Click:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"1"];
    }
}

-(void)button2Click:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"2"];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *model = _model[indexPath.row];
    if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"3"]) {
        return 210;
    }else
    {
        return 150;
    }
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
