//
//  TheDetailVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheDetailVC.h"
#import "TheDetailTableView.h"
#import "TheDetailModel.h"
@interface TheDetailVC ()<RefreshDelegate
>
@property (nonatomic , strong)TheDetailTableView *tableView;
@property (nonatomic , strong)NSMutableArray <TheDetailModel *>*model;
@end

@implementation TheDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"明细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self LoadData];
}


#pragma mark - Init
- (void)initTableView {

    self.tableView = [[TheDetailTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];

}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"802520";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"type"] = @"C";
    helper.parameters[@"currency"] = @"CNY";
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[TheDetailModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <TheDetailModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                TheDetailModel *model = (TheDetailModel *)obj;
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
        helper.parameters[@"type"] = @"C";
        helper.parameters[@"currency"] = @"CNY";
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <TheDetailModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                TheDetailModel *model = (TheDetailModel *)obj;
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
