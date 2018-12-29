//
//  HomeViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsDetailsViewController.h"

#import "HomeModel.h"
#import "HomeTableView.h"

//车贷计算器
#import "CarLoanCalculatorVC.h"
//展销中心
#import "ExhibitionCenterVC.h"
//商品详情
#import "GoodsDetailsViewController.h"
//推荐分期
#import "GoodsListVC.h"

@interface HomeViewController ()<RefreshDelegate>
@property (nonatomic , strong)HomeTableView *tableView;

@property (nonatomic, strong) NSMutableArray <HomeModel *>*carModel;

@property (nonatomic, strong) NSMutableArray <HomeModel *>*goodsModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    [self initTableView];

    [self LoadData];
}


#pragma mark - Init
- (void)initTableView {
    self.tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.goodsModel[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (index == 98) {
        CarLoanCalculatorVC *vc = [CarLoanCalculatorVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else if(index == 99)
    {
        GoodsListVC *vc = [GoodsListVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ExhibitionCenterVC *vc = [[ExhibitionCenterVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        HomeModel *model = self.carModel[index - 100];
        vc.brandCode = model.brandCode;
//        vc.seriesCode = model.seriesCode;
        NSLog(@"%@",self.carModel);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)bannerLoadData
{
//    MinicarsLifeWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"805806";
    http.parameters[@"location"] = @"0";
    http.showView = self.view;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        NSArray *array = responseObject[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            [muArray addObject:[NSString stringWithFormat:@"%@",[array[i][@"pic"] convertImageUrl]]];
        }
        self.tableView.bannerArray = muArray;
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

//推荐车系
-(void)RecommendedRange
{
    MinicarsLifeWeakSelf;

    TLNetworking *http = [TLNetworking new];
    http.code = RecommendedRangeURL;
    http.showView = self.view;
//    http.parameters[@"location"] = @"1";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {

        self.carModel = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.tableView.carModel = self.carModel;
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = RecommendedStagingURL;
    helper.parameters[@"location"] = @"1";
    helper.parameters[@"status"] = @"3";
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[HomeModel class]];

    [self.tableView addRefreshAction:^{
        [weakSelf RecommendedRange];
        [weakSelf bannerLoadData];
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
        helper.parameters[@"location"] = @"1";
        helper.parameters[@"status"] = @"3";
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
