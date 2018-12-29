//
//  ModifyayPasswordVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ModifyayPasswordVC.h"
#import "CustomTextFieldView.h"
#import "SendCodeView.h"

@interface ModifyayPasswordVC ()
{
    CustomTextFieldView *tfView1;
    SendCodeView *codeView;
    CustomTextFieldView *tfView2;
}

@end

@implementation ModifyayPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0){
        self.title = @"设置支付密码";

    }else
    {
        self.title = @"修改支付密码";
    }

    self.view.backgroundColor = BackColor;
    [self TheInterfaceDisplayView];
}

-(void)TheInterfaceDisplayView
{
    tfView1 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    tfView1.nameLabel.text = @"手机号";
    tfView1.nameTextField.text = [USERDEFAULTS objectForKey:MOBILE];
    tfView1.nameTextField.enabled = NO;
    tfView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tfView1];

    codeView = [[SendCodeView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 60)];
    codeView.nameLabel.text = @"手机验证码";
    codeView.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    codeView.nameTextField.placeholder = @"请输入验证码";
    [codeView.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeView];

    tfView2 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 60)];
    tfView2.nameLabel.text = @"支付密码";
    tfView2.nameTextField.placeholder = @"请输入支付密码";
    tfView2.nameTextField.secureTextEntry = YES;
    [self.view addSubview:tfView2];

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 240, SCREEN_WIDTH - 40, 50);
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
        [TLAlert alertWithInfo:@"请输入支付密码"];
        return;
    }


    TLNetworking *http = [TLNetworking new];

    if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0){
        http.code = @"805066";
        http.parameters[@"tradePwd"] = tfView2.nameTextField.text;

    }else
    {
        http.code = TopUpPaymentPassword;
        http.parameters[@"newTradePwd"] = tfView2.nameTextField.text;
    }

    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http.parameters[@"smsCaptcha"] = codeView.nameTextField.text;
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0){
            [TLAlert alertWithSucces:@"设置成功"];
        }else
        {
            [TLAlert alertWithSucces:@"修改成功"];
        }
        [[USERXX user] updateUserInfoWithNotification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0){

        http.parameters[@"bizType"] = @"805066";

    }else
    {
        http.parameters[@"bizType"] = TopUpPaymentPassword;
    }


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

@end
