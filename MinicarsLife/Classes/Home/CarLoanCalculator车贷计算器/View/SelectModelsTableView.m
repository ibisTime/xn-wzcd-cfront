//
//  SelectModelsTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SelectModelsTableView.h"

@interface SelectModelsTableView ()<UITableViewDelegate,UITableViewDataSource
>

@end

@implementation SelectModelsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];
    [cell addSubview:label];

    ExhibitionCenterModel *model = self.model[indexPath.row];
    label.text = model.name;

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LineBackColor;
    [cell addSubview:lineView];

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

    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
