//
//  MyCarLoanDetailsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MyCarLoanDetailsVC.h"
#import "MyCarLoanDetailsTableView.h"
#import "CarLoanCalculatorModel.h"
@interface MyCarLoanDetailsVC ()<RefreshDelegate>
{
    CGFloat cvalue;
    CGFloat MonthlyPayments;
    CGFloat SpendMore;
}
@property (nonatomic , strong)NSMutableArray <CarLoanCalculatorModel *>*carModel;

@property (nonatomic , strong)MyCarLoanDetailsTableView *tableView;

@end

@implementation MyCarLoanDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车贷计算器";
    [self initTableView];
    [self loadData];
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

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[MyCarLoanDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
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

        self.carModel = [CarLoanCalculatorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];

        NSLog(@"%@",_model.periods);
        for (int i = 0; i < self.carModel.count; i ++) {
            CarLoanCalculatorModel *carModel = self.carModel[i];
            if ([carModel.ckey isEqualToString:_model.periods]) {
                cvalue = [carModel.cvalue floatValue]/100;
                [self calculateADownPaymentPrice];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)calculateADownPaymentPrice
{
//    NSString *ADownPayment = [ADownPaymentStr stringByReplacingOccurrencesOfString:@"%" withString:@""];
    //    首付
//    ADownPaymentPrice = [ADownPayment floatValue]/100 * [self.carModel.salePrice floatValue]/1000;
    //    贷款总额
    CGFloat DKZE = [self.model.price floatValue]/1000 - [self.model.price floatValue]/1000 * self.model.sfRate;
    //    手续费
    CGFloat SXF = DKZE * cvalue;
    //    月供
    MonthlyPayments = (DKZE + SXF)/[self.model.periods floatValue];
    //    多花
    SpendMore = DKZE + SXF + self.model.sfAmount/1000  - [self.model.price floatValue]/1000;
    self.tableView.priceArray = @[@(MonthlyPayments),@(SpendMore)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
