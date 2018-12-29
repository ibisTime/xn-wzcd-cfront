//
//  CarLoanCalculatorVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanCalculatorVC.h"
#import "CarLoanCalculatorTableView.h"
#import "SelectedListView.h"
#import "CarLoanCalculatorModel.h"
//购车记录
#import "MyCarLoanApplicationVC.h"
#import "SelectModelsVC.h"
@interface CarLoanCalculatorVC ()<RefreshDelegate
>
{
//    首付
    NSString *ADownPaymentStr;
//    年限
    NSString *yearsStr;
//    首付价格
    CGFloat ADownPaymentPrice;
//    月供
    CGFloat MonthlyPayments;
//    多花
    CGFloat SpendMore;
//    银行利率
    CGFloat cvalue;
//    月数
    NSInteger month;
//    品牌code
    NSString *brandCode;
    NSString *name;

//
    NSString *allPrice;
}
@property (nonatomic , strong)CarLoanCalculatorTableView *tableView;
@property (nonatomic, strong) NSMutableArray <CarLoanCalculatorModel *>*model;
@end

@implementation CarLoanCalculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车贷计算器";
    ADownPaymentStr = @"30%";
    NSLog(@"%.2f",[ADownPaymentStr floatValue]);
    [self.view addSubview:self.tableView];
    [self initTableView];
    [self loadData];
    [self calculateADownPaymentPrice];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:PPLoadDataNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction1:) name:CXLoadDataNotice object:nil];

}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    brandCode = notification.userInfo[@"brandCode"];
    self.tableView.contactArray1 = @[[NSString stringWithFormat:@"%@",notification.userInfo[@"name"]],@""];
    name = [NSString stringWithFormat:@"%@",notification.userInfo[@"name"]];
    self.carModel = nil;
    self.tableView.carModel = nil;
    [self calculateADownPaymentPrice];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction1:(NSNotification *)notification{
    self.tableView.contactArray1 = @[name,[NSString stringWithFormat:@"%@",notification.userInfo[@"name"]]];
    self.carModel = notification.userInfo[@"model"];
    self.tableView.carModel = self.carModel;
    [self calculateADownPaymentPrice];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PPLoadDataNotice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PPLoadDataNotice object:nil];
}




#pragma mark - Init
- (void)initTableView {

    self.tableView = [[CarLoanCalculatorTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.state = self.state;
    self.tableView.carModel = self.carModel;

}


- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_state isEqualToString:@"100"]) {


    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SelectModelsVC *vc = [[SelectModelsVC alloc]init];
            vc.titleStr = @"品牌";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            if ([USERXX isBlankString:brandCode] == YES) {
                [TLAlert alertWithInfo:@"请输先选择品牌"];
            }else
            {
                SelectModelsVC *vc = [[SelectModelsVC alloc]init];
                vc.titleStr = @"车系";
                vc.brandCode = brandCode;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {

            NSArray *dataArray = @[@"30%",@"50%",@"70%"];
            NSMutableArray *nameArray = [NSMutableArray array];
            for (int i = 0;  i < dataArray.count; i ++) {
                [nameArray addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dataArray[i]]]];

            }
            SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
            view.isSingle = YES;
            view.array = nameArray;
            view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                [LEEAlert closeWithCompletionBlock:^{
                    NSLog(@"选中的%@" , array);
                    SelectedListModel *model = array[0];
                    ADownPaymentStr = model.title;
                    self.tableView.nameArray = @[ADownPaymentStr,yearsStr];
                    [self calculateADownPaymentPrice];
                }];
            };
            [LEEAlert alert].config
            .LeeTitle(@"选择首付比")
            .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
            .LeeCustomView(view)
            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
            .LeeClickBackgroundClose(YES)
            .LeeShow();


        }else{


            NSMutableArray *nameArray = [NSMutableArray array];
            for (int i = 0;  i < _model.count; i ++) {
                CarLoanCalculatorModel *model = _model[i];
                [nameArray addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%ld年",[model.ckey integerValue]/12]]];
            }

            SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
            view.isSingle = YES;
            view.array = nameArray;
            view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                [LEEAlert closeWithCompletionBlock:^{
                    NSLog(@"选中的%@" , array);
                    SelectedListModel *model = array[0];
                    yearsStr = model.title;
                    self.tableView.nameArray = @[ADownPaymentStr,yearsStr];
                     NSString *str = [model.title stringByReplacingOccurrencesOfString:@"年" withString:@""];
                    month = [str integerValue] * 12;
                    [self calculateADownPaymentPrice];
                }];
            };
            [LEEAlert alert].config
            .LeeTitle(@"选择还款年限")
            .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
            .LeeCustomView(view)
            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
            .LeeClickBackgroundClose(YES)
            .LeeShow();


        }
    }
}

//申请车贷
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    if([USERXX user].isLogin == NO) {
        [TLAlert alertWithTitle:@"提示" msg:@"您还未登陆,是否前去登陆" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {

            LoginViewController *vc = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [rootViewController presentViewController:nav animated:YES completion:nil];

        } confirm:^(UIAlertAction *action) {

        }];
    }else
    {
        TLNetworking *http = [TLNetworking new];
        http.code = ToApplyForCarLoanURL;
        http.showView = self.view;
        http.parameters[@"brandCode"] = _carModel.brandCode;
        http.parameters[@"brandName"] = _carModel.brandName;
        http.parameters[@"carCode"] = _carModel.code;
        http.parameters[@"carName"] = _carModel.name;
        http.parameters[@"createDatetime"] = [self getCurrentTimes];
        http.parameters[@"periods"] = @(month);

        http.parameters[@"price"] = self.carModel.salePrice;
        http.parameters[@"saleDesc"] = [NSString stringWithFormat:@"首付%.2f，月供%.2f,多花%.2f",ADownPaymentPrice,MonthlyPayments,SpendMore];
//        @(),@()
        http.parameters[@"seriesCode"] = self.carModel.seriesCode;
        http.parameters[@"seriesName"] = self.carModel.seriesName;
        http.parameters[@"sfAmount"] = @(ADownPaymentPrice * 1000);
        NSString *ADownPayment = [ADownPaymentStr stringByReplacingOccurrencesOfString:@"%" withString:@""];
        http.parameters[@"sfRate"] = [NSString stringWithFormat:@"%.1f",[ADownPayment floatValue]/100];
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

        NSLog(@"%@",[USERDEFAULTS objectForKey:USER_ID]);

        http.parameters[@"userMobile"] = [USERDEFAULTS objectForKey:MOBILE];
        [http postWithSuccess:^(id responseObject) {


            MyCarLoanApplicationVC *vc = [[MyCarLoanApplicationVC alloc]init];
            [self.navigationController pushViewController:vc animated:nil];

        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }

}

-(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}

-(void)loadData
{

    TLNetworking *http = [TLNetworking new];
    http.code = TheCalculatorURL;
    http.showView = self.view;
    http.parameters[@"limit"] = @"20";
    http.parameters[@"start"] = @"1";
    http.parameters[@"type"] = @"car_periods";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {

        self.model = [CarLoanCalculatorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        CarLoanCalculatorModel *model = self.model[0];
        yearsStr = [NSString stringWithFormat:@"%ld年",[model.ckey integerValue]/12];
        cvalue = [model.cvalue floatValue]/100;
        self.tableView.nameArray = @[ADownPaymentStr,yearsStr];
        self.tableView.model = self.model;
        month = [model.ckey integerValue];
        [self calculateADownPaymentPrice];

        [_tableView reloadData];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)calculateADownPaymentPrice
{
    NSString *ADownPayment = [ADownPaymentStr stringByReplacingOccurrencesOfString:@"%" withString:@""];
//    首付
    ADownPaymentPrice = [ADownPayment floatValue]/100 * [self.carModel.salePrice floatValue]/1000;
    //    贷款总额
    CGFloat DKZE = [self.carModel.salePrice floatValue]/1000 - ADownPaymentPrice;
    //    手续费
    CGFloat SXF = DKZE * cvalue;
    //    月供
    MonthlyPayments = (DKZE + SXF)/month;
    //    多花
    SpendMore = DKZE + SXF + ADownPaymentPrice - [self.carModel.salePrice floatValue]/1000;
    self.tableView.priceArray = @[@(ADownPaymentPrice),@(MonthlyPayments),@(SpendMore)];
}


//在页面出现的时候就将黑线隐藏起来
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

@end
