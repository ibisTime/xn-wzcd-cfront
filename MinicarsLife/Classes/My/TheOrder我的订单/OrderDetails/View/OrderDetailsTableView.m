//
//  OrderDetailsTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "OrderDetailsTableView.h"
#import "OrderDetailsInfoCell.h"
#define OrderDetailsInfo @"OrderDetailsInfoCell"
#import "OrderDetailsGoodsCell.h"
#define OrderDetailsGoods @"OrderDetailsGoodsCell"

@interface OrderDetailsTableView ()<UITableViewDelegate,UITableViewDataSource
>
@end

@implementation OrderDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[OrderDetailsInfoCell class] forCellReuseIdentifier:OrderDetailsInfo];
        [self registerClass:[OrderDetailsGoodsCell class] forCellReuseIdentifier:OrderDetailsGoods];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OrderDetailsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailsInfo forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.model = self.model;
        return cell;
    }


    OrderDetailsGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailsGoods forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.model = self.model;
    return cell;

}
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }
    return 110;

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
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
