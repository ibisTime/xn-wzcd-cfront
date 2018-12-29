
//
//  CarLoansAllVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoansAllVC.h"
#import "CarLoansTableView.h"
#import "CarLoansModel.h"

#import "MyCarLoanDetailsVC.h"
@interface CarLoansAllVC ()<RefreshDelegate
>
@property (nonatomic , strong)CarLoansTableView *tableView;

@property (nonatomic , strong)NSMutableArray <CarLoansModel *>*model;

@end

@implementation CarLoansAllVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self initTableView];
    [self LoadData];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[CarLoansTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];


}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCarLoanDetailsVC *vc = [[MyCarLoanDetailsVC alloc]init];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = MyCarLoanApplicationURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.tableView = self.tableView;
    [helper modelClass:[CarLoansModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <CarLoansModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                CarLoansModel *model = (CarLoansModel *)obj;
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

        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <CarLoansModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                CarLoansModel *model = (CarLoansModel *)obj;
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




@end
