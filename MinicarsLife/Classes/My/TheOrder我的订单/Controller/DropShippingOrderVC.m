//
//  DropShippingOrderVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DropShippingOrderVC.h"
#import "OrderTableView.h"
#import "OrderModel.h"
#import "PayVC.h"
#import "OrderDetailsVC.h"
@interface DropShippingOrderVC ()<RefreshDelegate
>
@property (nonatomic , strong)OrderTableView *tableView;
@property (nonatomic , strong)NSMutableArray <OrderModel *>*model;

@end

@implementation DropShippingOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self.view addSubview:self.tableView];
    [self initTableView];
    [self LoadData];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[OrderTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];

}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsVC *vc = [OrderDetailsVC new];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    OrderModel *model = self.model[index];
    if ([state isEqualToString:@"1"]) {

        [TLAlert alertWithTitle:@"提示" msg:@"是否取消该订单" confirmMsg:@"确认" cancleMsg:@"取消" cancle:nil confirm:^(UIAlertAction *action) {
            TLNetworking *http = [TLNetworking new];
            http.code = CancelTheOrderURL;
            http.showView = self.view;
            http.parameters[@"code"] = model.code;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            [http postWithSuccess:^(id responseObject) {
                [self LoadData];
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];
        }];

    }else
    {
        if ([model.status isEqualToString:@"1"]) {
            PayVC *vc = [PayVC new];
            vc.price = [model.productOrderList[0][@"price"] floatValue]/1000;
            vc.code = model.code;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            [TLAlert alertWithTitle:@"提示" msg:@"是否确认收货" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
                TLNetworking *http = [TLNetworking new];
                http.code = ConfirmTheGoodsURL;
                http.showView = self.view;
                http.parameters[@"code"] = model.code;
                http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
                [http postWithSuccess:^(id responseObject) {
                    [self LoadData];
                } failure:^(NSError *error) {
                    WGLog(@"%@",error);
                }];
            } confirm:^(UIAlertAction *action) {

            }];
        }

    }
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = TheOrderURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"status"] = @"2";
    helper.tableView = self.tableView;
    [helper modelClass:[OrderModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            NSMutableArray <OrderModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                OrderModel *model = (OrderModel *)obj;
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
        //        helper.parameters[@"status"] = @"3";
        helper.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
        helper.parameters[@"status"] = @"2";
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <OrderModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                OrderModel *model = (OrderModel *)obj;
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
