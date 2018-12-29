//
//  VehicleDetailsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "VehicleDetailsVC.h"
#import "VehicleDetailsTbaleView.h"

#import "CarLoanCalculatorVC.h"
@interface VehicleDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)VehicleDetailsTbaleView *tableView;

@property (nonatomic , strong)UIButton *applyForButton;



@end

@implementation VehicleDetailsVC

-(UIButton *)applyForButton
{
    if (!_applyForButton) {
        _applyForButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _applyForButton.frame = CGRectMake(20, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 40, 50);
        [_applyForButton setTitle:@"申请购买" forState:(UIControlStateNormal)];
        _applyForButton.titleLabel.font = HGfont(14);
        _applyForButton.backgroundColor = MainColor;
        _applyForButton.layer.masksToBounds = YES;
        _applyForButton.layer.cornerRadius = 5;
        [_applyForButton addTarget:self action:@selector(applyForButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _applyForButton;
}

-(void)applyForButtonClick
{
    CarLoanCalculatorVC *vc = [[CarLoanCalculatorVC alloc]init];
    vc.carModel = self.model;
    vc.state = @"100";
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.title = @"车辆详情";
    [self initTableView];
//    [self loadData];
    [self.view addSubview:self.applyForButton];

}
#pragma mark - Init
- (void)initTableView {

    self.tableView = [[VehicleDetailsTbaleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];

    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];

}


@end
