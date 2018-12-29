//
//  TheBalanceOfVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheBalanceOfVC.h"

//记录
#import "TheDetailVC.h"
//提现
#import "WithdrawalVC.h"
#import "TheBalanceOfTableView.h"
#import "AccountModel.h"

@interface TheBalanceOfVC ()

@property (nonatomic , strong)TheBalanceOfTableView *tableView;
@property (nonatomic , strong)AccountModel *model;

@end

@implementation TheBalanceOfVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self initTableView];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"明细" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];

    UIButton *confirmButton = [UIButton buttonWithTitle:@"提现" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:5];
    confirmButton.frame = CGRectMake(20, SCREEN_HEIGHT - 60 - kNavigationBarHeight, SCREEN_WIDTH - 40, 50);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];

    [self loadData];

}


-(void)loadData
{
    MinicarsLifeWeakSelf;
    [self.tableView addRefreshAction:^{

        TLNetworking *http1 = [TLNetworking new];
        http1.code = AccountsCheckingListURL;
        http1.showView = weakSelf.view;
        http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
        http1.parameters[@"currency"] = @"CNY";
        [http1 postWithSuccess:^(id responseObject) {
            weakSelf.model = [AccountModel mj_objectWithKeyValues:responseObject[@"data"][@"accountList"][0]];

            NSLog(@"%@",responseObject[@"data"][@"accountList"][0]);
            weakSelf.tableView.model = weakSelf.model;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshHeader];

        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
            WGLog(@"%@",error);
        }];
    }];

    [weakSelf.tableView beginRefreshing];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[TheBalanceOfTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];

//    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];

}

//明细
-(void)RightButtonClick
{
    TheDetailVC *vc = [TheDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

//提现
-(void)confirmButtonClick
{
    WithdrawalVC *vc = [WithdrawalVC new];
    vc.accointModel = self.model;
    [self.navigationController pushViewController:vc animated:YES];
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
