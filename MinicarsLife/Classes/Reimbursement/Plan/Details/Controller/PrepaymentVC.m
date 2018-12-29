//
//  PrepaymentVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/8/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PrepaymentVC.h"

@interface PrepaymentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *dataDic;
}
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation PrepaymentVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提前还款";

    UIButton *confirmButton = [UIButton buttonWithTitle:@"确认还款" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:5];
    confirmButton.frame = CGRectMake(20, SCREEN_HEIGHT - 60 - kNavigationBarHeight, SCREEN_WIDTH - 40, 50);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];
    [self loadData];
}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630047";
    http.parameters[@"key"] = @"tq_service";
    [http postWithSuccess:^(id responseObject) {
        dataDic = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

-(void)confirmButtonClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否提前还款" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {

        TLNetworking *http = [TLNetworking new];
        http.code = @"630512";
        http.showView = self.view;
        http.parameters[@"updater"] = [USERDEFAULTS  objectForKey:USER_ID];
        http.parameters[@"code"] = _model.code;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"申请提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];

    } confirm:^(UIAlertAction *action) {

    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
    }
    NSArray *array = @[@"未还总金额",@"提前还款服务费",@"还款总额",@"还款卡号"];
    NSArray *array1;
    if (self.model.refType == 0) {
        NSDictionary *dic;

        dic = self.model.budgetOrder;
        NSLog(@"%@",dic);
        array1 = @[[NSString stringWithFormat:@"%.2f",self.model.restAmount/1000],[NSString stringWithFormat:@"%.2f",[dataDic[@"cvalue"] floatValue]],[NSString stringWithFormat:@"%.2f",[dic[@"loanAmount"] floatValue]/1000],dic[@"repayBankcardNumber"]];

    }else
    {
        NSDictionary *dic;
        dic = self.model.mallOrder;
        array1 = @[[NSString stringWithFormat:@"%.2f",self.model.restAmount/1000],[NSString stringWithFormat:@"%.2f",[dataDic[@"cvalue"] floatValue]],[NSString stringWithFormat:@"%.2f",[dic[@"loanAmount"] floatValue]/1000],dic[@"bankcardNumber"]];

    }
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.font = HGfont(15);
    cell.detailTextLabel.text = array1[indexPath.row];
    cell.detailTextLabel.font = HGfont(15);
    cell.detailTextLabel.textColor = GaryTextColor;
//    cell.imageView.image = [UIImage imageNamed:@"abc"];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LineBackColor;
    [cell addSubview:lineView];
    return cell;



}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01;

}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}



@end
