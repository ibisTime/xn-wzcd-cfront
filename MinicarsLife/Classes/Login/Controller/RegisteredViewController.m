//
//  RegisteredViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegisteredView.h"
#import "SendVerificationCodeView.h"
#import "TermsOfServiceView.h"
#import "AboutUsVC.h"
#define HEIGHT 51
#define DISTANCE 10

@interface RegisteredViewController ()
{
    RegisteredView *PhoneView;
    RegisteredView *PassWordView;
    SendVerificationCodeView *codeView;
    RegisteredView *ConfirmPasswordView;
    TermsOfServiceView *TermsOfService;
    NSInteger type;
}

@property (nonatomic , strong)UIButton *RegisteredButton;

@end

@implementation RegisteredViewController

-(UIButton *)RegisteredButton
{
    if (!_RegisteredButton) {

        _RegisteredButton = [UIButton buttonWithTitle:@"确认注册" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:10];
        _RegisteredButton.frame = CGRectMake(20, DISTANCE*10 + HEIGHT*4, SCREEN_WIDTH - 40, 50);
        [_RegisteredButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _RegisteredButton.tag = 102;
    }
    return _RegisteredButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    type = 100;
    self.view.backgroundColor = BackColor;
    [self customView];
    [self TheNavigationBar];
    [self.view addSubview:self.RegisteredButton];
}

-(void)customView
{
    PhoneView = [[RegisteredView alloc]initWithFrame:CGRectMake(0, DISTANCE, SCREEN_WIDTH, HEIGHT - 1)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    PhoneView.Registered_Label.text = @"手机号";
    PhoneView.Registered_TextField.placeholder = @"请输入手机号码";
    PhoneView.Registered_TextField.tag = 1000;
    PhoneView.Registered_TextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:PhoneView];

    codeView = [[SendVerificationCodeView alloc]initWithFrame:CGRectMake(0, DISTANCE + HEIGHT, SCREEN_WIDTH, HEIGHT - 1)];
    codeView.backgroundColor = [UIColor whiteColor];
    [codeView.code_Button addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
    codeView.code_Button.tag = 101;
    codeView.code_TextField.tag = 1001;
    [self.view addSubview:codeView];

    PassWordView = [[RegisteredView alloc]initWithFrame:CGRectMake(0, DISTANCE*2 + HEIGHT*2 , SCREEN_WIDTH, HEIGHT - 1)];
    PassWordView.backgroundColor = [UIColor whiteColor];
    PassWordView.Registered_Label.text = @"密码";
    PassWordView.Registered_TextField.placeholder = @"请输入密码";
    PassWordView.Registered_TextField.tag = 1002;
    PassWordView.Registered_TextField.secureTextEntry = YES;
    [self.view addSubview:PassWordView];


    ConfirmPasswordView = [[RegisteredView alloc]initWithFrame:CGRectMake(0, DISTANCE*2 + HEIGHT*3, SCREEN_WIDTH, HEIGHT - 1)];
    ConfirmPasswordView.backgroundColor = [UIColor whiteColor];
    ConfirmPasswordView.Registered_Label.text = @"确认密码";
    ConfirmPasswordView.Registered_TextField.placeholder = @"请输入密码";
    ConfirmPasswordView.Registered_TextField.tag = 1003;
    ConfirmPasswordView.Registered_TextField.secureTextEntry = YES;
    [self.view addSubview:ConfirmPasswordView];

    TermsOfService  = [[TermsOfServiceView alloc]initWithFrame:CGRectMake(0, DISTANCE*4 + HEIGHT*4, SCREEN_WIDTH, 20)];
    [TermsOfService.chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];

    [TermsOfService.termsOfServiceButton addTarget:self action:@selector(termsOfServiceButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:TermsOfService];
}

-(void)chooseButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    type = sender.selected + 100;
}

-(void)termsOfServiceButtonClick
{
    AboutUsVC *vc = [[AboutUsVC alloc]init];
    vc.titleStr = @"服务条款";
    vc.ckey = @"reg_protocol";
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)TheNavigationBar
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    [self.LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    [self.LeftBackbButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.LeftBackbButton.tag = 100;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)buttonMethodClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
        {
            //返回
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 1:
        {
            UITextField *textField1 = [self.view viewWithTag:1000];
            if ([textField1.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入手机号"];
                return;
            }
            //发送验证码
            TLNetworking *http = [TLNetworking new];
            http.code = VERIFICATION_CODE_CODE;
            http.showView = self.view;
            http.parameters[@"mobile"] = textField1.text;
            http.parameters[@"bizType"] = USER_REG_CODE;

            [http postWithSuccess:^(id responseObject) {
                WGLog(@"%@",responseObject);
                [self SendVerificationCode:sender];
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];
        }
            break;
        case 2:
        {
            if (type == 100) {
                [TLAlert alertWithInfo:@"请勾选我已阅读并同意《服务条款》"];
                return;
            }
            UITextField *textField1 = [self.view viewWithTag:1000];
            UITextField *textField2 = [self.view viewWithTag:1001];
            UITextField *textField3 = [self.view viewWithTag:1002];
            UITextField *textField4 = [self.view viewWithTag:1003];
            NSLog(@"=============%@",textField1.text);
            if ([textField1.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入手机号"];
                return;
            }
            if ([textField2.text isEqualToString:@""]) {

                [TLAlert alertWithInfo:@"请输入验证码"];
                return;
            }
            if ([textField3.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入密码"];
                return;
            }
            if ([textField4.text isEqualToString:@""]) {
                [TLAlert alertWithInfo:@"请输入确认密码"];
                return;
            }
            if (![textField3.text isEqualToString:textField4.text]) {
                [TLAlert alertWithInfo:@"密码不一致"];
                return;
            }
            //确认注册
            TLNetworking *http = [TLNetworking new];
            http.code = USER_REG_CODE;
            http.showView = self.view;
            http.parameters[@"kind"] = @"C";
            http.parameters[@"mobile"] = textField1.text;
            http.parameters[@"smsCaptcha"] = textField2.text;
            http.parameters[@"loginPwd"] = textField3.text;
            http.parameters[@"nickname"] = @"暂无";

            [http postWithSuccess:^(id responseObject) {
                WGLog(@"%@",responseObject);
                [TLAlert alertWithSucces:@"注册成功"];
                [self dismissViewControllerAnimated:YES completion:nil];

            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];

        }
            break;

        default:
            break;
    }
}

-(void)SendVerificationCode:(UIButton *)sender
{


    NSLog(@"123");

    __block NSInteger time = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                sender.backgroundColor = MainColor;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitle:[NSString stringWithFormat:@"%.2d后重发", seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor grayColor];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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
