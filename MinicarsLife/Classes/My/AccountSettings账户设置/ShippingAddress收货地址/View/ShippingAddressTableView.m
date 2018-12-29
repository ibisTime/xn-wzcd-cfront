//
//  ShippingAddressTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ShippingAddressTableView.h"
#import "ShippingAddressCell.h"
#define ShippingAddress @"ShippingAddressCell"

@interface ShippingAddressTableView ()<UITableViewDelegate,UITableViewDataSource
>
{
    ShippingAddressCell *cell;
}

@end

@implementation ShippingAddressTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ShippingAddressCell class] forCellReuseIdentifier:ShippingAddress];
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
    cell = [tableView dequeueReusableCellWithIdentifier:ShippingAddress forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.defaultButton addTarget:self action:@selector(defaultButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.defaultButton.tag = 100 + indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.deleteButton.tag = 100 + indexPath.row;
    [cell.modifyButton addTarget:self action:@selector(modifyButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.modifyButton.tag = 100 + indexPath.row;
    if (self.model.count > 0) {
        cell.model = self.model[indexPath.row];
    }
    return cell;

}

//默认
-(void)defaultButtonClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 100 selectRowState:@"1"];
    }

}

//编辑
-(void)modifyButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 100 selectRowState:@"2"];
    }
}

//删除
-(void)deleteButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 100 selectRowState:@"3"];
    }
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
    return 120 + cell.addressLabel.self.frame.size.height;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
