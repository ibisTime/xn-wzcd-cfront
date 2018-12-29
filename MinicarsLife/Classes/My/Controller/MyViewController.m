#import "MyViewController.h"
#import "MyHeadView.h"
#import "MYCell.h"

//账户设置
#import "AccountSettingsVC.h"
//信用报告
#import "CreditReportVC.h"
//我的消息
#import "MessageVC.h"
//我的车贷申请
#import "MyCarLoanApplicationVC.h"
//我的订单
#import "TheOrderVC.h"
//联系客服
#import "ContactVC.h"
//账户
#import "TheBalanceOfVC.h"
//积分
#import "IntegralVC.h"

#import "AboutUsVC.h"

#import "FaceToFaceSignVC.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MyHeadDelegate
>
{
    NSString *accountNumber;
    NSString *faceStr;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)MyHeadView *headView;
@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic, strong) UIAlertController *alertCtrl;

@end

@implementation MyViewController

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
        _titleLabel.text = @"我的";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName :@"Georgia-Bold" size:18];
    }
    return _titleLabel;
}

#pragma mark -- 顶部试图懒加载
-(MyHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170 + kStatusBarHeight)];
        _headView.delegate = self;
    }
    return _headView;
}

-(void)MyHeadButton:(NSInteger)tag
{
    if (tag == 0)
    {
        NSLog(@"账户");
        TheBalanceOfVC *vc = [[TheBalanceOfVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag == 1)
    {
        NSLog(@"积分");
        IntegralVC *vc = [[IntegralVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        AccountSettingsVC *vc = [[AccountSettingsVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}




#pragma mark -- tableView懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame;
        NSLog(@"%d",kStatusBarHeight);
        tableView_frame = CGRectMake(0, -kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT + 44 + kStatusBarHeight - kTabBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MYCell class] forCellReuseIdentifier:@"MYCell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titleLabel];
    self.tableView.tableHeaderView = self.headView;
    [self loadData];
    faceStr = @"";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"信用报告";
        }
            break;
        case 1:
        {
            cell.iconImage.image = HGImage(@"myicon2");
            cell.nameLabel.text = @"开始面签";
        }
            break;
        case 2:
        {
            NSArray *nameArray = @[@"我的消息",@"我的车贷申请",@"我的商品订单",@"联系客服"];
            NSArray *imageArray = @[HGImage(@"myicon2"),HGImage(@"myicon3"),HGImage(@"myicon3"),HGImage(@"myicon5")];
            cell.iconImage.image = imageArray[indexPath.row];
            cell.nameLabel.text = nameArray[indexPath.row];
        }
            break;
        case 3:
        {
            cell.iconImage.image = HGImage(@"myicon6");
            cell.nameLabel.text = @"关于我们";
        }
            break;

        default:
            break;
    }

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
        {
            CreditReportVC *vc = [[CreditReportVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.accountNumber = accountNumber;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            [self AlertControllerView];
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                MessageVC *vc = [[MessageVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 1) {
                MyCarLoanApplicationVC *vc = [[MyCarLoanApplicationVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 2) {
                TheOrderVC *vc = [[TheOrderVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 3) {
                ContactVC *vc = [[ContactVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 3:
        { 
            AboutUsVC *vc = [[AboutUsVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.titleStr = @"关于我们";
            vc.ckey = @"about_us";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
}

-(void)AlertControllerView
{

    if ([faceStr isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@""];
        TLNetworking *http = [TLNetworking new];
        http.code = @"630800";
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

        [http postWithSuccess:^(id responseObject) {

            [SVProgressHUD showWithStatus:@""];
            [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];

            [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                faceStr = responseObject[@"data"][@"txAppCode"];
                [SVProgressHUD dismiss];
                //提示框添加文本输入框
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    for(UITextField *text in alert.textFields){
                        NSLog(@"text = %@", text.text);

                        // 1. 创建live房间页面
                        FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
                        liveRoomVC.hidesBottomBarWhenPushed = YES;
                        // 2. 创建房间配置对象
                        ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                        option.imOption.imSupport = NO;
                        // 不自动打开摄像头
                        option.avOption.autoCamera = NO;
                        // 不自动打开mic
                        option.avOption.autoMic = NO;
                        // 设置房间内音视频监听
                        option.memberStatusListener = liveRoomVC;
                        // 设置房间中断事件监听
                        option.roomDisconnectListener = liveRoomVC;

                        // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                        option.controlRole = @"cd_room";

                        // 3. 调用创建房间接口，传入房间ID和房间配置对象
                        [[ILiveRoomManager getInstance] joinRoom:[text.text intValue] option:option succ:^{
                            // 加入房间成功，跳转到房间页
                            [self.navigationController pushViewController:liveRoomVC animated:YES];
                        } failed:^(NSString *module, int errId, NSString *errMsg) {
                            // 加入房间失败
                            self.alertCtrl.title = @"加入房间失败";
                            self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                            [self presentViewController:self.alertCtrl animated:YES completion:nil];
                        }];


                    }
                }];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                    NSLog(@"action = %@", alert.textFields);
                }];
                [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"请输入面签房间号";
                    textField.borderStyle = UITextBorderStyleRoundedRect;
                    textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
                }];
                [alert addAction:okAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];

                // 登录成功，跳转到创建房间页

            } failed:^(NSString *module, int errId, NSString *errMsg) {
                NSLog(@"%@",errMsg);
                [SVProgressHUD dismiss];
                [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
            }];
            NSLog(@"%@",responseObject);

        } failure:^(NSError *error) {
            WGLog(@"%@",error);
            [SVProgressHUD dismiss];
        }];
    }else
    {
        //提示框添加文本输入框
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            for(UITextField *text in alert.textFields){
                NSLog(@"text = %@", text.text);

                // 1. 创建live房间页面
                FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
                liveRoomVC.hidesBottomBarWhenPushed = YES;
                // 2. 创建房间配置对象
                ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                option.imOption.imSupport = NO;
                // 不自动打开摄像头
                option.avOption.autoCamera = NO;
                // 不自动打开mic
                option.avOption.autoMic = NO;
                // 设置房间内音视频监听
                option.memberStatusListener = liveRoomVC;
                // 设置房间中断事件监听
                option.roomDisconnectListener = liveRoomVC;

                // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                option.controlRole = @"cd_room";

                // 3. 调用创建房间接口，传入房间ID和房间配置对象
                [[ILiveRoomManager getInstance] joinRoom:[text.text intValue] option:option succ:^{
                    // 加入房间成功，跳转到房间页
                    [self.navigationController pushViewController:liveRoomVC animated:YES];
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    // 加入房间失败
                    self.alertCtrl.title = @"加入房间失败";
                    self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                    [self presentViewController:self.alertCtrl animated:YES completion:nil];
                }];


            }
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            NSLog(@"action = %@", alert.textFields);
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入面签房间号";
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
        }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

#pragma mark - Accessor
- (UIAlertController *)alertCtrl {
    if (!_alertCtrl) {
        _alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }] ;
        [_alertCtrl addAction:action];
    }
    return _alertCtrl;
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark -- 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark -- 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)loadData
{
    MinicarsLifeWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = DetailsOfTheUserDataURL;
    http.showView = self.view;
    http.isShowMsg = YES;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        if ([USERXX isBlankString:responseObject[@"data"][@"nickname"]] == YES) {
            [USERDEFAULTS setObject:@"" forKey:NICKNAME];
        }else
        {
            [USERDEFAULTS setObject:responseObject[@"data"][@"nickname"] forKey:NICKNAME];
        }
        if ([USERXX isBlankString:responseObject[@"data"][@"photo"]] == YES) {
            [USERDEFAULTS setObject:@"" forKey:PHOTO];
        }else
        {
            [USERDEFAULTS setObject:responseObject[@"data"][@"photo"] forKey:PHOTO];
        }
        [USERDEFAULTS setObject:responseObject[@"data"][@"mobile"] forKey:MOBILE];
        [_headView.headImage sd_setImageWithURL:[NSURL URLWithString:[[USERDEFAULTS objectForKey:PHOTO] convertImageUrl]] placeholderImage:HGImage(@"myheadimage")];
        _headView.nameLabel.text = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:NICKNAME]];
        _headView.phoneLabel.text = [USERDEFAULTS objectForKey:MOBILE];
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

    TLNetworking *http1 = [TLNetworking new];
    http1.code = AccountsCheckingListURL;
    http1.showView = self.view;
    http1.isShowMsg = YES;
    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    [http1 postWithSuccess:^(id responseObject) {
        NSArray *array = responseObject[@"data"][@"accountList"];
        for (int i = 0; i < array.count; i ++) {
            if ([array[i][@"currency"] isEqualToString:@"CNY"]) {
                [USERDEFAULTS setObject:array[i][@"amount"] forKey:YY];
            }
            if ([array[i][@"currency"] isEqualToString:@"JF"]) {
                [USERDEFAULTS setObject:array[i][@"amount"] forKey:JF];
            }
            if ([array[i][@"currency"] isEqualToString:@"XYF"]) {
                accountNumber = array[i][@"accountNumber"];
            }
        }
        if ([USERXX isBlankString:[USERDEFAULTS objectForKey:YY]] == YES) {
            [_headView.balanceButton setTitle:@"账户余额:0.00" forState:(UIControlStateNormal)];
        }else
        {
            [_headView.integralButton setTitle:[NSString stringWithFormat:@"账户余额:%.2f",[[USERDEFAULTS objectForKey:YY] floatValue]/1000] forState:(UIControlStateNormal)];
        }
        if ([USERXX isBlankString:[USERDEFAULTS objectForKey:JF]] == YES) {
            [_headView.integralButton setTitle:@"账户积分:0.00" forState:(UIControlStateNormal)];
        }else
        {
            [_headView.integralButton setTitle:[NSString stringWithFormat:@"账户积分:%.2f",[[USERDEFAULTS objectForKey:JF] floatValue]/1000] forState:(UIControlStateNormal)];
        }
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];


}





#pragma mark -- 滑动动画效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = 170 + kStatusBarHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / (170 + kStatusBarHeight);
        CGFloat width = SCREEN_WIDTH;
        // 拉伸后图片位置
        self.headView.backImage.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
    }
}
@end
