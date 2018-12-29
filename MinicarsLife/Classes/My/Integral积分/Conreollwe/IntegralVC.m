//
//  IntegralVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "IntegralVC.h"

@interface IntegralVC ()<UITableViewDelegate,UITableViewDataSource
>
{
    UIView *headView;
    UILabel *nameLabel;
    UILabel *numberLabel;

}
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation IntegralVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame;
        NSLog(@"%d",kStatusBarHeight);
        tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70);
        _tableView = [[UITableView alloc]initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户积分";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self TheInterfaceDisplayView];

}

-(void)TheInterfaceDisplayView
{

    headView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headView.backgroundColor = MainColor;
    [self.view addSubview:headView];

    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26.5, SCREEN_WIDTH, 15)];
    nameLabel.text = @"当前账户积分";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = HGColor(255, 255, 255);
    nameLabel.font = HGfont(15);
    [headView addSubview:nameLabel];

    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41.5+15, SCREEN_WIDTH, 45)];

    numberLabel.text = [NSString stringWithFormat:@"%.2f",[[USERDEFAULTS objectForKey:JF] floatValue]];
    numberLabel.textColor = HGColor(255, 255, 255);
    numberLabel.font = HGfont(45);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:numberLabel];



    self.tableView.tableHeaderView = headView;

}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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

//在页面出现的时候就将黑线隐藏起来
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

@end
