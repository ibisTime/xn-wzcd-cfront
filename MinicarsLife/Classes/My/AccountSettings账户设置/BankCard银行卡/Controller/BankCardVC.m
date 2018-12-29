

#import "BankCardVC.h"
#import "BankCardTableView.h"
#import "BankCardModel.h"
#import "AddBankCardVC.h"
@interface BankCardVC ()<RefreshDelegate>
@property (nonatomic , strong)BankCardTableView *tableView;

@property (nonatomic , strong)NSMutableArray <BankCardModel *>*model;
@end

@implementation BankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"银行卡";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"添加" forState:(UIControlStateNormal)];
    self.view.backgroundColor = BackColor;
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:BankCardPageLoadData object:nil];

}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self LoadData];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BankCardPageLoadData object:nil];
}


-(void)rightButtonClick
{
    AddBankCardVC *vc = [AddBankCardVC new];
    vc.naviStr = @"绑定银行卡";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initTableView {
    self.tableView = [[BankCardTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_state == 100) {
        // 2.创建通知
        NSDictionary *dic = @{@"model":self.model[indexPath.row]};
        NSNotification *notification =[NSNotification notificationWithName:ChooseBankCardNotice object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        AddBankCardVC *vc = [[AddBankCardVC alloc]init];
        vc.naviStr = @"修改银行卡";
        vc.model = self.model[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = BankListURL;
//    helper.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[BankCardModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

        //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <BankCardModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                BankCardModel *model = (BankCardModel *)obj;
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
        helper.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
        helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种


            NSMutableArray <BankCardModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                BankCardModel *model = (BankCardModel *)obj;
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
