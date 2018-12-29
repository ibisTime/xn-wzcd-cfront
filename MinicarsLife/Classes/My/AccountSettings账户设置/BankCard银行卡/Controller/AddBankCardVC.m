//
//  AddBankCardVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AddBankCardVC.h"
#import "AddBankCardTableView.h"
#import "SelectedListView.h"
@interface AddBankCardVC ()<RefreshDelegate>
{
    NSString *bankCode;
}
@property (nonatomic , strong)AddBankCardTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;
@end

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _naviStr;
    [self initTableView];
    [self LoadData];


    if (![_naviStr isEqualToString:@"绑定银行卡"]) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
        [self.RightButton setTitle:@"删除" forState:(UIControlStateNormal)];
        self.view.backgroundColor = BackColor;
        [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (index == 100) {
        if (self.dataArray.count == 0) {
            return;
        }
        NSMutableArray *nameArray = [NSMutableArray array];
        for (int i = 0;  i < _dataArray.count; i ++) {
//            BankCardModel *model = _model[i];
            [nameArray addObject:[[SelectedListModel alloc] initWithSid:i Title:_dataArray[i][@"bankName"]]];
        }

        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = nameArray;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                NSLog(@"选中的%@" , array);

                SelectedListModel *model = array[0];
                UITextField *textField = [self.view viewWithTag:1002];
                textField.text = model.title;
                for (int i = 0; i < _dataArray.count; i ++) {
                    if ([model.title isEqualToString:_dataArray[i][@"bankName"]]) {
                        bankCode = _dataArray[i][@"bankCode"];
                    }
                }
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"请选择银行")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }else
    {
        [self addBankCard];
    }
}

-(void)addBankCard
{


    if ([_naviStr isEqualToString:@"绑定银行卡"]) {

        UITextField *textField1 = [self.view viewWithTag:1000];
        UITextField *textField2 = [self.view viewWithTag:1001];
        UITextField *textField3 = [self.view viewWithTag:1002];
        UITextField *textField4 = [self.view viewWithTag:1003];
        UITextField *textField5 = [self.view viewWithTag:1004];

        if ([textField1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入持卡人姓名"];
            return;
        }
        if ([textField2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择银行"];
            return;
        }
        if ([textField4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入开户支行"];
            return;
        }
        if ([textField5.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入卡号"];
            return;
        }

        TLNetworking *http = [TLNetworking new];
        http.code = BindingOfBankCARDSURL;
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
        http.parameters[@"bankCode"] = bankCode;
        http.parameters[@"realName"] = textField1.text;
        http.parameters[@"bindMobile"] = textField2.text;
        http.parameters[@"bankName"] = textField3.text;
        http.parameters[@"subbranch"] = textField4.text;
        http.parameters[@"updater"] = textField1.text;
        http.parameters[@"bankcardNumber"] = textField5.text;

        [http postWithSuccess:^(id responseObject) {
            WGLog(@"%@",responseObject);
            [self CreateNotification];
            [TLAlert alertWithSucces:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];

    }else
    {
        UITextField *textField1 = [self.view viewWithTag:1000];
        UITextField *textField2 = [self.view viewWithTag:1001];
        UITextField *textField3 = [self.view viewWithTag:1002];
        UITextField *textField4 = [self.view viewWithTag:1003];
        UITextField *textField5 = [self.view viewWithTag:1004];

        if ([textField1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入持卡人姓名"];
            return;
        }
        if ([textField2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择银行"];
            return;
        }
        if ([textField4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入开户支行"];
            return;
        }
        if ([textField5.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入卡号"];
            return;
        }

        TLNetworking *http = [TLNetworking new];
        http.code = ModifyBankCardURL;
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
        http.parameters[@"bankCode"] = bankCode;
        http.parameters[@"realName"] = textField1.text;
        http.parameters[@"bindMobile"] = textField2.text;
        http.parameters[@"bankName"] = textField3.text;
        http.parameters[@"subbranch"] = textField4.text;
        http.parameters[@"updater"] = textField1.text;
        http.parameters[@"bankcardNumber"] = textField5.text;
        http.parameters[@"code"] = _model.code;

        [http postWithSuccess:^(id responseObject) {
            WGLog(@"%@",responseObject);
            [TLAlert alertWithSucces:@"添加成功"];
            [self CreateNotification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }


}

-(void)LoadData
{
    MinicarsLifeWeakSelf;

    TLNetworking *http = [TLNetworking new];
    http.code = QueryChannelBankURL;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        weakSelf.dataArray = responseObject[@"data"];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


//删除银行卡
-(void)rightButtonClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否删除该银行卡" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
    } confirm:^(UIAlertAction *action) {
        TLNetworking *http = [TLNetworking new];
        http.code = deleteBankCardURL;
        http.showView = self.view;
        http.parameters[@"code"] = _model.code;
        http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
        [http postWithSuccess:^(id responseObject) {
            [self CreateNotification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }];

}

- (void)initTableView {
    self.tableView = [[AddBankCardTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    if ([self.naviStr isEqualToString:@"修改银行卡"]) {
        NSArray *textFdArray = @[_model.realName,_model.bindMobile,_model.bankName,_model.subbranch,_model.bankcardNumber];
        NSLog(@"%@",textFdArray);
        self.tableView.array = textFdArray;
    }

}

-(void)CreateNotification
{
    // 2.创建通知
    NSNotification *notification =[NSNotification notificationWithName:BankCardPageLoadData object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
