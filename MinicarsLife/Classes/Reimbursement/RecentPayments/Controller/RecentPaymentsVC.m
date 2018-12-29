//
//  RecentPaymentsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecentPaymentsVC.h"
#import "NearFutureModel.h"
#import "NearFutureTableView.h"
#import "RecordDetailsVC.h"
#import "DetailsVC.h"

@interface RecentPaymentsVC ()<RefreshDelegate>
@property (nonatomic , strong)NearFutureTableView *tableView;

@property (nonatomic , strong)NSMutableArray <NearFutureModel *>*model;

@end

@implementation RecentPaymentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self LoadData];
}


#pragma mark - Init
- (void)initTableView {

    self.tableView = [[NearFutureTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];

}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsVC *vc = [[DetailsVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630543";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[NearFutureModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <NearFutureModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NearFutureModel *model = (NearFutureModel *)obj;
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
        helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <NearFutureModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NearFutureModel *model = (NearFutureModel *)obj;
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
