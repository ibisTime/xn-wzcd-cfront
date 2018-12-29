//
//  SubmitOrdersVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrdersVC.h"
#import "SubmitOrdersTableView.h"
#import "GoodsDetailsBottomView.h"
#import "PayVC.h"

//地址
#import "ShippingAddressVC.h"
#import "AddressModel.h"
//银行卡
#import "BankCardVC.h"
#import "BankCardModel.h"

@interface SubmitOrdersVC ()<RefreshDelegate>
{
//    还款编号
    NSString *bankcardCode;
//
    NSString *reAddress;
    NSString *reMobile;
    NSString *receiver;
    NSDictionary *dataDic;
}
@property (nonatomic , strong)AddressModel *adressModel;
@property (nonatomic , strong)NSMutableArray <AddressModel *>*addressArray;
@property (nonatomic , strong)BankCardModel *bankCardModel;
@property (nonatomic , strong)NSMutableArray <BankCardModel *>*bankCardArray;
@property (nonatomic , strong)SubmitOrdersTableView *tableView;
@property (nonatomic , strong)GoodsDetailsBottomView *BottomView;
@end

@implementation SubmitOrdersVC

-(GoodsDetailsBottomView *)BottomView
{
    if (!_BottomView) {
        _BottomView = [[GoodsDetailsBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50, SCREEN_WIDTH, 50)];
        [_BottomView.shoppingButton addTarget:self action:@selector(chooseViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_BottomView.shoppingButton setTitle:@"发起扣款" forState:(UIControlStateNormal)];

        for (int i = 0; i < _model.productSpecsList.count; i ++) {
            if ([_model.productSpecsList[i][@"name"] isEqualToString:self.selectArray[0]]) {
                dataDic = _model.productSpecsList[i];
            }
        }

        NSString *str = [NSString stringWithFormat:@"待支付: %.2f",[dataDic[@"sfRate"] floatValue]*[dataDic[@"price"] floatValue]/1000];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:GaryTextColor
                        range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:MainColor
                        range:NSMakeRange(4, str.length - 4)];
        _BottomView.MonthlyPaymentsLabel.attributedText = attrStr;

    }
    return _BottomView;
}

-(void)chooseViewClick
{
    if ([USERXX isBlankString:reAddress] == YES) {
        [TLAlert alertWithInfo:@"请选择收货地址"];
        return;
    }
    if ([USERXX isBlankString:bankcardCode] == YES) {
        [TLAlert alertWithInfo:@"请选择银行"];
        return;
    }
    NSString *productSpecsCode;
    NSString *specifications = [self.selectArray componentsJoinedByString:@","];
    for (int i = 0; i < _model.productSpecsList.count; i ++) {
        if ([_model.productSpecsList[i][@"name"] isEqualToString:specifications]) {
            productSpecsCode = _model.productSpecsList[i][@"code"];
        }
    }
    TLNetworking *http = [TLNetworking new];
    http.code = PlaceOrderImmediatelyURL;
    http.showView = self.view;
    http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"productSpecsCode"] = productSpecsCode;
    http.parameters[@"bankcardCode"] = bankcardCode;
    http.parameters[@"quantity"] = @"1";
    http.parameters[@"reAddress"] = reAddress;
    http.parameters[@"reMobile"] = reMobile;
    http.parameters[@"receiver"] = receiver;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [TLAlert alertWithSucces:@"下单成功"];
        PayVC *vc = [PayVC new];
        vc.price = [dataDic[@"sfRate"] floatValue]*[dataDic[@"price"] floatValue]/1000;
        vc.code = responseObject[@"data"];
        [self.navigationController pushViewController:vc animated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];



}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单提交";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.BottomView];
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ChooseAddressNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction1:) name:ChooseBankCardNotice object:nil];
    [self addressLoadData];
    [self BankCardLoadData];

}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{

    self.adressModel = notification.userInfo[@"model"];
    [self ShippingAddress];
}

-(void)addressLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = ShippingAddressURL;
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        self.addressArray = [AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.addressArray.count > 0) {
            for (int i = 0; i < self.addressArray.count; i ++) {
                AddressModel *model = self.addressArray[i];
                if ([model.isDefault isEqualToString:@"1"]) {
                    self.adressModel = model;
                    [self ShippingAddress];
                }
            }
        }
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)ShippingAddress
{
    self.tableView.addressModel = self.adressModel;
    reAddress = self.adressModel.addressee;
    reMobile = self.adressModel.mobile;
    receiver = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",self.adressModel.province,self.adressModel.city,self.adressModel.area,self.adressModel.detail];
    [self.tableView reloadData];
}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction1:(NSNotification *)notification{

    self.bankCardModel = notification.userInfo[@"model"];
    [self BankCard];
}

-(void)BankCardLoadData
{

    TLNetworking *http = [TLNetworking new];
    http.code = @"802016";
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        self.bankCardArray = [BankCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.bankCardArray.count > 0) {
            BankCardModel *model = self.bankCardArray[0];
            self.bankCardModel = model;
            [self BankCard];
        }
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)BankCard
{
    self.tableView.bankCardModel = self.bankCardModel;
    bankcardCode = self.bankCardModel.code;
    [self.tableView reloadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ChooseAddressNotice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ChooseBankCardNotice object:nil];
}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[SubmitOrdersTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight- 50) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.homeModel = self.model;
    NSString *specifications = [self.selectArray componentsJoinedByString:@","];
    self.tableView.specificationsStr = specifications;
    [self.view addSubview:self.tableView];

}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShippingAddressVC *vc = [ShippingAddressVC new];
        vc.state = 100;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        BankCardVC *vc = [BankCardVC new];
        vc.state = 100;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
