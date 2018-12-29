//
//  GoodsListVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GoodsListVC.h"
#import "GoodsDetailsViewController.h"
#import "GoodsListTableView.h"
#import "HomeModel.h"
@interface GoodsListVC ()<RefreshDelegate>
@property (nonatomic , strong)GoodsListTableView *tableView;

@property (nonatomic, strong) NSMutableArray <HomeModel *>*goodsModel;
@end

@implementation GoodsListVC



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"推荐分期";
    [self initTableView];
    [self LoadData];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[GoodsListTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];

}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc]init];
    vc.model = self.goodsModel[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = RecommendedStagingURL;
    helper.parameters[@"status"] = @"3";
    helper.parameters[@"location"] = @"0";

    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[HomeModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            NSMutableArray <HomeModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                HomeModel *model = (HomeModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
            weakSelf.goodsModel = shouldDisplayCoins;
            weakSelf.tableView.goodsModel = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"status"] = @"3";
        helper.parameters[@"location"] = @"0";
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <HomeModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                HomeModel *model = (HomeModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {

                [shouldDisplayCoins addObject:model];
                //                }

            }];

            //
            weakSelf.goodsModel = shouldDisplayCoins;
            weakSelf.tableView.goodsModel = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];

    }];

    [self.tableView beginRefreshing];
}



@end
