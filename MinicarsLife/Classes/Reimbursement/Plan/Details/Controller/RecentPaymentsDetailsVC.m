//
//  RecentPaymentsDetailsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/16.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecentPaymentsDetailsVC.h"
#import "RecordDetailsCell.h"
#import "RecordDetailsHeadCell.h"
#import "RecordPlanCell.h"
#define RecordDetails @"RecordDetailsCell"
#define RecordDetailsHead @"RecordDetailsHeadCell"
#define RecordPlan @"RecordPlanCell"
@interface RecentPaymentsDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation RecentPaymentsDetailsVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RecordDetailsCell class] forCellReuseIdentifier:RecordDetails];
        [_tableView registerClass:[RecordDetailsHeadCell class] forCellReuseIdentifier:RecordDetailsHead];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车贷详情";
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
    if (indexPath.section == 0)
    {
        RecordDetailsHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordDetailsHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    RecordDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordDetails forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _model;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 125;
    }
    return 35 * 6 + 8;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 0.01;
    }
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
