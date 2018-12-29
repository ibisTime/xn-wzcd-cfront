//
//  TheDetailTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/16.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheDetailTableView.h"
#import "TheDetailCell.h"
#define TheDetail @"TheDetailCell"

@interface TheDetailTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation TheDetailTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TheDetailCell class] forCellReuseIdentifier:TheDetail];

    }
    return self;


}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TheDetail forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _model[indexPath.row];
    return cell;

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
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
