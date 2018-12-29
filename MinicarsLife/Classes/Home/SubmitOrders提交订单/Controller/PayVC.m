//
//  PayVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PayVC.h"
#import "PayAllPriceCell.h"
#import "PayWayCell.h"
#define PayAllPrice @"PayAllPriceCell"
#define PayWay @"PayWayCell"
//支付密码
#import "ModifyayPasswordVC.h"
#import "TheOrderVC.h"
@interface PayVC ()<UITableViewDelegate,UITableViewDataSource,PayWayCellDelegate>
{
    NSInteger payINT;
}
@property (nonatomic , strong)UITableView *tableView;
@end

@implementation PayVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PayAllPriceCell class] forCellReuseIdentifier:PayAllPrice];
        [_tableView registerClass:[PayWayCell class] forCellReuseIdentifier:PayWay];

    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"支付";
    [self.view addSubview:self.tableView];
    payINT = 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 0)
    {
        PayAllPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:PayAllPrice forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.priceLbl.text = [NSString stringWithFormat:@"¥:%.2f",_price];
        return cell;
    }
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:PayWay forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;


}

-(void)PayWayCellButton:(NSInteger)tag
{
    payINT = tag;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 50;
    }
    return 153;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0.01;
    }
    return 30;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 10;
    }
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = [UIColor whiteColor];

        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
        nameLbl.text = @"支付方式";
        [headView addSubview:nameLbl];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        return headView;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *footerView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 40, SCREEN_WIDTH - 40, 45);
        [confirmButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(16);
        [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [footerView addSubview:confirmButton];

        return footerView;
    }
    return nil;
}

-(void)confirmButtonClick
{

    if (payINT == 100) {
        if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0){

            [TLAlert alertWithTitle:@"提示" msg:@"您还未设置支付密码,是否前去设置" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
                ModifyayPasswordVC *vc = [ModifyayPasswordVC new];
                [self.navigationController pushViewController:vc animated:YES];
            } confirm:^(UIAlertAction *action) {

            }];
        }else
        {

            [TLAlert alertWithTitle:@"请输入支付密码"
                                msg:@""
                         confirmMsg:@"确定"
                          cancleMsg:@"取消"
                        placeHolder:@"请输入支付密码"
                              maker:self cancle:^(UIAlertAction *action) {

                              } confirm:^(UIAlertAction *action, UITextField *textField) {

                                  [self confirmWithdrawalsWithPwd:textField.text];

                              }];


        }

    }else
    {
        [TLAlert alertWithInfo:@"暂无该支付方式"];
        return;
    }


}

-(void)confirmWithdrawalsWithPwd:(NSString *)pwd
{
    

    TLNetworking *http = [TLNetworking new];
    http.code = @"808052";
    http.showView = self.view;
    http.parameters[@"payType"] = @"1";
    http.parameters[@"code"] = _code;
    http.parameters[@"tradePwd"] = pwd;


    [http postWithSuccess:^(id responseObject) {
        if ([_state isEqualToString:@"100"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            TheOrderVC *vc = [[TheOrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

@end
