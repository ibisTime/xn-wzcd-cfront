//
//  ExhibitionCenterVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ExhibitionCenterVC.h"
#import "ExhibitionCenterTableView.h"
#import "VehicleDetailsVC.h"
#import "ExhibitionCenterModel.h"

@interface ExhibitionCenterVC ()<RefreshDelegate>
{
    UISearchBar * bar;
    BOOL _isSearch;
}
@property (nonatomic , strong)ExhibitionCenterTableView *tableView;

@property (nonatomic, strong) NSMutableArray <ExhibitionCenterModel *>*model;

@end

@implementation ExhibitionCenterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"展销中心";
    [self initTableView];
    [self LoadData:@""];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[ExhibitionCenterTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTablevi BarName:(NSString *)name
{
    [self LoadData:name];
}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VehicleDetailsVC *vc = [[VehicleDetailsVC alloc]init];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData:(NSString *)name
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = VehicleManagementURL;
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"brandCode"] = _brandCode;
//    helper.parameters[@"seriesCode"] = _seriesCode;
    helper.parameters[@"name"] = name;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[ExhibitionCenterModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
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
        helper.parameters[@"status"] = @"1";
        helper.parameters[@"brandCode"] = weakSelf.brandCode;
        helper.parameters[@"name"] = name;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
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
