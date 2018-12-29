//
//  RecordDetailsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordDetailsVC.h"
#import "RecordDetailsCell.h"
#import "RecordDetailsHeadCell.h"
#import "RecordPlanCell.h"
#define RecordDetails @"RecordDetailsCell"
#define RecordDetailsHead @"RecordDetailsHeadCell"
#define RecordPlan @"RecordPlanCell"

#import "PrepaymentVC.h"

#import "RepaymentPlanVC.h"


@interface RecordDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *confirmButton;
}
@property (nonatomic , strong)UITableView *tableView;


@end

@implementation RecordDetailsVC

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
        [_tableView registerClass:[RecordPlanCell class] forCellReuseIdentifier:RecordPlan];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车贷详情";

    confirmButton = [UIButton buttonWithTitle:@"提前还款" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:5];
    confirmButton.frame = CGRectMake(20, SCREEN_HEIGHT - 60 - kNavigationBarHeight, SCREEN_WIDTH - 40, 50);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];
    [self loadData];
    if (_model.restAmount/1000 == 0) {
        confirmButton.hidden = YES;
        _tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);

    }
}

//630047   tq_service

-(void)confirmButtonClick
{
    PrepaymentVC *vc = [[PrepaymentVC alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
    if (indexPath.section == 1)
    {
        RecordDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordDetails forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    RecordPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordPlan forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630147";
    [http postWithSuccess:^(id responseObject) {
        NSArray *array =  responseObject[@"data"];

        for (int i = 0 ; i < array.count; i ++) {
            if ([_model.curNodeCode isEqualToString:array[i][@"code"]]) {
                UILabel *label = [self.view viewWithTag:1005];
                label.text = [NSString stringWithFormat:@"%@",array[i][@"name"]];
            }
        }
        [self.tableView reloadData];

    } failure:^(NSError *error) {

    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        RepaymentPlanVC *vc = [[RepaymentPlanVC alloc]init];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 125;
    }
    if (indexPath.section == 1)
    {
        return 35 * 6 + 8;
    }
    return 50;
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
