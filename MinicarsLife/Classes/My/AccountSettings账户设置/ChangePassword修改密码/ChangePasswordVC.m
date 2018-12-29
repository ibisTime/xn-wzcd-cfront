//
//  ChangePasswordVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "CustomTextFieldView.h"
#import "SendCodeView.h"
@interface ChangePasswordVC ()
{
    CustomTextFieldView *tfView1;
    SendCodeView *codeView;
    CustomTextFieldView *tfView2;
    CustomTextFieldView *tfView3;
}
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = BackColor;
    [self TheInterfaceDisplayView];
    if ([_state isEqualToString:@"100"]) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
        [self.RightButton setTitle:@"添加" forState:(UIControlStateNormal)];
        self.view.backgroundColor = BackColor;
        [self.LeftBackbButton addTarget:self action:@selector(LeftBackbButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)LeftBackbButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)TheInterfaceDisplayView
{
    tfView1 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    if (![_state isEqualToString:@"100"]) {

        tfView1.nameTextField.text = [USERDEFAULTS objectForKey:MOBILE];
        tfView1.nameTextField.enabled = NO;
    }
    tfView1.nameLabel.text = @"手机号";
    tfView1.nameTextField.placeholder = @"请输入手机号";
    tfView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tfView1];

    codeView = [[SendCodeView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 60)];
    codeView.nameLabel.text = @"验证码";
    codeView.nameTextField.placeholder = @"请输入验证码";
    [codeView.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeView];

    tfView2 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 60)];
    tfView2.nameLabel.text = @"新密码";
    tfView2.nameTextField.secureTextEntry = YES;
    tfView2.nameTextField.placeholder = @"不少于6位";
    [self.view addSubview:tfView2];

    tfView3 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 60)];
    tfView3.nameLabel.text = @"确认密码";
    tfView3.nameTextField.secureTextEntry = YES;
    tfView3.nameTextField.placeholder = @"不少于6位";
    [self.view addSubview:tfView3];

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 290, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    confirmButton.titleLabel.font = HGfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];
}

-(void)confirmButtonClick
{
    if ([tfView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([codeView.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入验证码"];
        return;
    }
    if ([tfView2.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入新密码"];
        return;
    }
    if (![tfView3.nameTextField.text isEqualToString:tfView2.nameTextField.text]) {
        [TLAlert alertWithInfo:@"密码不一致"];
        return;
    }

    TLNetworking *http = [TLNetworking new];
    http.code = ChangePasswordURL;
    http.showView = self.view;
    http.parameters[@"kind"] = @"C";
    http.parameters[@"mobile"] = tfView1.nameTextField.text;
    http.parameters[@"smsCaptcha"] = codeView.nameTextField.text;
    http.parameters[@"newLoginPwd"] = tfView2.nameTextField.text;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [TLAlert alertWithSucces:@"修改成功"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        vc.state = @"100";
        [USERDEFAULTS removeObjectForKey:USER_ID];
        [USERDEFAULTS removeObjectForKey:TOKEN_ID];
        [rootViewController presentViewController:nav animated:YES completion:nil];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)sendButtonClick:(UIButton *)sender
{
    if ([tfView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    //发送验证码
    TLNetworking *http = [TLNetworking new];
    http.code = VERIFICATION_CODE_CODE;
    http.showView = self.view;
    http.parameters[@"kind"] = @"C";
    http.parameters[@"mobile"] = tfView1.nameTextField.text;
    http.parameters[@"bizType"] = ChangePasswordURL;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [self SendVerificationCode:sender];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
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
