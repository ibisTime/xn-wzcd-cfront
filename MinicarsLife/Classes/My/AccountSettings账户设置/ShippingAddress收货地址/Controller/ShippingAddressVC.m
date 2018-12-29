//
//  ShippingAddressVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ShippingAddressVC.h"

#import "EditorAddressVC.h"

#import "EditorAddressVC.h"
#import "ShippingAddressTableView.h"

#import "AddressModel.h"

@interface ShippingAddressVC ()<RefreshDelegate>


@property (nonatomic , strong)ShippingAddressTableView *tableView;

@property (nonatomic, strong) NSMutableArray <AddressModel *>*model;

@end

@implementation ShippingAddressVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"地址管理";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, SCREEN_HEIGHT - 60 - kNavigationBarHeight, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"新增地址" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    confirmButton.titleLabel.font = HGfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];

    [self initTableView];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[ShippingAddressTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];
    [self LoadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:AddressPageLoadData object:nil];

}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self addressLoadData];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AddressPageLoadData object:nil];
}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_state == 100) {

        // 2.创建通知
        NSDictionary *dic = @{@"model":self.model[indexPath.row]};
        NSNotification *notification =[NSNotification notificationWithName:ChooseAddressNotice object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{

    AddressModel *model = self.model[index];

    if ([state isEqualToString:@"1"])
    {
        TLNetworking *http = [TLNetworking new];
        http.code = SetTheDefaultAddress;
        http.showView = self.view;
        http.parameters[@"code"] = model.code;

        [http postWithSuccess:^(id responseObject) {
            [self addressLoadData];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }
    else if ([state isEqualToString:@"2"])
    {
        EditorAddressVC *vc = [[EditorAddressVC alloc]init];
        vc.naviStr = @"编辑地址";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [TLAlert alertWithTitle:@"提示" msg:@"是否删除该地址" confirmMsg:@"确认" cancleMsg:@"取消" cancle:nil confirm:^(UIAlertAction *action) {
            TLNetworking *http = [TLNetworking new];
            http.code = DeleteEceiptAddressURL;
            http.showView = self.view;
            http.parameters[@"code"] = model.code;

            [http postWithSuccess:^(id responseObject) {
                [self addressLoadData];
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];
        }];
        

    }
}

-(void)confirmButtonClick
{
    EditorAddressVC *vc = [[EditorAddressVC alloc]init];
    vc.naviStr = @"添加地址";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    MinicarsLifeWeakSelf;

    [self.tableView addRefreshAction:^{

        [weakSelf addressLoadData];
    }];
    [self.tableView beginRefreshing];
}

-(void)addressLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = ShippingAddressURL;
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];


    [http postWithSuccess:^(id responseObject) {

        self.model = [AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.model = self.model;
        [self.tableView reloadData];
        [self.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}



@end
