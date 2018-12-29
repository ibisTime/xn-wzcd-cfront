//
//  LoginViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"
#import "BaseTabBarViewController.h"
#import "ChangePasswordVC.h"
#import "AboutUsVC.h"
@interface LoginViewController ()

@property (nonatomic , strong)UIButton *ForgotPasswordButton;

@property (nonatomic , strong)UIButton *loginButton;

@end

@implementation LoginViewController

-(UIButton *)ForgotPasswordButton
{
    if (!_ForgotPasswordButton) {
        _ForgotPasswordButton = [UIButton buttonWithTitle:@"忘记密码?" titleColor:GaryTextColor backgroundColor:BackColor titleFont:14 cornerRadius:0];
        _ForgotPasswordButton.frame = CGRectMake(SCREEN_WIDTH - 90, 120, 80, 20);
        [_ForgotPasswordButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _ForgotPasswordButton.tag = 102;
    }
    return _ForgotPasswordButton;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithTitle:@"确认登录" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:10];
        _loginButton.frame = CGRectMake(20, 170, SCREEN_WIDTH - 40, 50);
        [_loginButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _loginButton.tag = 103;
    }
    return _loginButton;
}

-(void)buttonMethodClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
        {
            [self backViewController];
        }
            break;
        case 1:
        {
            RegisteredViewController *vc = [[RegisteredViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            vc.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;

            [self.navigationController presentViewController:nav animated:YES completion:nil];
            
        }
            break;
        case 2:
        {
            ChangePasswordVC *vc = [[ChangePasswordVC alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.state = @"100";
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 3:
        {
            UITextField *textTF1 = [self.view viewWithTag:1000];
            UITextField *textTF2 = [self.view viewWithTag:1001];
            if ([textTF1.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入手机号"];
                return;
            }
            if ([textTF2.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入密码"];
                return;
            }
            TLNetworking *http = [TLNetworking new];
            http.code = USER_LOGIN_CODE;
            http.showView = self.view;
            http.parameters[@"kind"] = @"C";
            http.parameters[@"loginName"] = textTF1.text;
            http.parameters[@"loginPwd"] = textTF2.text;

            [http postWithSuccess:^(id responseObject) {
                WGLog(@"%@",responseObject);
                [USERDEFAULTS setObject:responseObject[@"data"][@"token"] forKey:TOKEN_ID];
                [USERDEFAULTS setObject:responseObject[@"data"][@"userId"] forKey:USER_ID];
                [[USERXX user] updateUserInfoWithNotification];

                [self backViewController];
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];

        }
            break;

        default:
            break;
    }
}

-(void)backViewController
{
    [self.view endEditing:YES];
    if ([_state isEqualToString:@"100"]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        BaseTabBarViewController *TabBarVC = [[BaseTabBarViewController alloc]init];
        window.rootViewController = TabBarVC;

    }else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = BackColor;
    [self TheNavigationBar];
    [self loginCustomView];
    [self.view addSubview:self.ForgotPasswordButton];
    [self.view addSubview:self.loginButton];

}

-(void)TheNavigationBar
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    [self.RightButton setTitle:@"注册" forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.LeftBackbButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    self.LeftBackbButton.tag = 100;
    [self.RightButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.RightButton.tag = 101;
}

-(void)loginCustomView
{
    NSArray *loginTextArray = @[@"请输入手机号",@"请输入账号密码"];
    for (int i = 0; i < 2; i ++) {
        CGFloat x = 0;
        CGFloat y = 10 + i * 51;
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = 50;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];

        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
        iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"login%d",i]];
        [backView addSubview:iconImage];

        UITextField *loginTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 60, 50)];
        loginTextField.placeholder = loginTextArray[i];
        loginTextField.tag = 1000 + i;
        loginTextField.font = HGfont(16);
        if (i == 0) {
            loginTextField.keyboardType = UIKeyboardTypePhonePad;
        }else
        {
            loginTextField.secureTextEntry = YES;
            loginTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        [loginTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        [backView addSubview:loginTextField];

    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
