//
//  MessageVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTableView.h"
#import "MessageModel.h"
@interface MessageVC ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;
@property (nonatomic , strong)NSMutableArray <MessageModel *>*model;

@end

@implementation MessageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的消息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    [self LoadData];

}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = MyNewsURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"toKind"] = @"C";
    helper.parameters[@"channelType"] = @"4";
    helper.parameters[@"pushType"] = @"41";
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"fromSystemCode"] = @"CD-HTWT000020";
    helper.parameters[@"toSystemCode"] = @"CD-HTWT000020";
    helper.tableView = self.tableView;
    [helper modelClass:[MessageModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <MessageModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                MessageModel *model = (MessageModel *)obj;
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


            NSMutableArray <MessageModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                MessageModel *model = (MessageModel *)obj;
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
