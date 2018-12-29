//
//  NickNameVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "NickNameVC.h"

@interface NickNameVC ()
@property (nonatomic , strong)UITextField *nickNameTextField;
@property (nonatomic , strong)UILabel *textLabel;
@end

@implementation NickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"昵称";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"确认" forState:(UIControlStateNormal)];
    self.view.backgroundColor = BackColor;
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self TheInterfaceDisplayView];

}

-(void)rightButtonClick
{
    if ([_nickNameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入昵称"];
        return;
    }
    //发送验证码
    TLNetworking *http = [TLNetworking new];
    http.code = ModifyTheNicknameURL;
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http.parameters[@"nickname"] = _nickNameTextField.text;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [TLAlert alertWithSucces:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)TheInterfaceDisplayView
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];

    _nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 60)];
    [_nickNameTextField setValue:[UIColor blackColor]  forKeyPath:@"_placeholderLabel.textColor"];
    if ([USERXX isBlankString:[USERDEFAULTS objectForKey:NICKNAME]] == YES) {
        _nickNameTextField.placeholder = @"请输入昵称";
    }else
    {
        _nickNameTextField.text = [USERDEFAULTS objectForKey:NICKNAME];
    }

    
    _nickNameTextField.font = HGfont(14);
    [_nickNameTextField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
    [backView addSubview:_nickNameTextField];

    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, SCREEN_WIDTH - 30, 20)];
    _textLabel.text = @"昵称不能超过8个汉字或16个字母";
    _textLabel.font = HGfont(14);
    [self.view addSubview:_textLabel];
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
