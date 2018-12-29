//
//  CreditReportVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CreditReportVC.h"
#import "CreditReportTableView.h"
#import "CreditReportModel.h"
@interface CreditReportVC ()<RefreshDelegate>
@property (nonatomic , strong)CreditReportTableView *tableView;
@property (nonatomic, strong) NSMutableArray <CreditReportModel *>*model;

@end

@implementation CreditReportVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信用报告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self initTableView];
    [self LoadData];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[CreditReportTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];

}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = RecordURL;
    helper.parameters[@"accountNumber"] = self.accountNumber;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[CreditReportModel class]];

    [self.tableView addRefreshAction:^{
        [weakSelf loadData1];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <CreditReportModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                CreditReportModel *model = (CreditReportModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"accountNumber"] = weakSelf.accountNumber;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <CreditReportModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                CreditReportModel *model = (CreditReportModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {

                [shouldDisplayCoins addObject:model];
                //                }

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];

    [self.tableView beginRefreshing];
}

-(void)loadData1
{
    MinicarsLifeWeakSelf;
    TLNetworking *http1 = [TLNetworking new];
    http1.code = AccountsCheckingListURL;
    http1.showView = weakSelf.view;
    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http1.parameters[@"currency"] = @"XYF";
    [http1 postWithSuccess:^(id responseObject) {

        weakSelf.tableView.amount = responseObject[@"data"][@"accountList"][0][@"amount"];
        [_tableView reloadData];

    } failure:^(NSError *error) {

        WGLog(@"%@",error);
    }];
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
