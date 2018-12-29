//
//  RepaymentPlanVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanVC.h"
#import "RepaymentPlanHeadCell.h"
#import "RepaymentPlanCell.h"
#define RepaymentPlanHead @"RepaymentPlanHeadCell"
#define RepaymentPlan @"RepaymentPlanCell"
@interface RepaymentPlanVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation RepaymentPlanVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RepaymentPlanHeadCell class] forCellReuseIdentifier:RepaymentPlanHead];
        [_tableView registerClass:[RepaymentPlanCell class] forCellReuseIdentifier:RepaymentPlan];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款计划";
    dataArray = _model.repayPlanList;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {

        return dataArray.count;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        RepaymentPlanHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RepaymentPlanHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    RepaymentPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:RepaymentPlan forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataArray.count > 0) {
        cell.dic = dataArray[indexPath.row];
    }
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
        return 165;
    }

    return 62 + 15 * 2 + 3;
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
