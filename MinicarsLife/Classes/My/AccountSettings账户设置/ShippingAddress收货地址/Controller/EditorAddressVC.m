//
//  EditorAddressVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "EditorAddressVC.h"
#import "CustomTextFieldView.h"
#import "AddressPickerView.h"
#define SCREEN [UIScreen mainScreen].bounds.size
@interface EditorAddressVC ()<AddressPickerViewDelegate>
{
    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@property (nonatomic ,strong) AddressPickerView * pickerView;

@property (nonatomic ,strong) UIButton          * addressBtn;

@end

@implementation EditorAddressVC

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN.height , SCREEN.width, 215)];
        _pickerView.delegate = self;
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.title = self.naviStr;
    [self.view addSubview:self.pickerView];
    [self TheInterfaceDisplayView];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)TheInterfaceDisplayView
{
    NSArray *nameArray = @[@"收货人姓名",@"手机号",@"省市区",@"详细地址"];
    NSArray *placeholderArray = @[@"请输入姓名",@"请输入手机号",@"请选择省市区",@"请输入详细地址"];
    for (int i = 0; i < 4; i ++) {
        CustomTextFieldView *tfView1 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 10 + i%4*60, SCREEN_WIDTH, 60)];
        tfView1.nameLabel.text = nameArray[i];
        tfView1.nameTextField.placeholder = placeholderArray[i];
        tfView1.nameTextField.tag = 1000+i;
        tfView1.nameTextField.clearsOnBeginEditing = NO;
        tfView1.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        if ( i == 1) {
            tfView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
        }
        if ([_naviStr isEqualToString:@"编辑地址"]) {
            NSArray *textArray = @[
              [NSString stringWithFormat:@"%@",_model.addressee],
              [NSString stringWithFormat:@"%@",_model.mobile],
              [NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.area],
              [NSString stringWithFormat:@"%@",_model.detail]];
            tfView1.nameTextField.text = textArray[i];

            _province = _model.province;
            _city = _model.city;
            _area = _model.area;

        }

        [self.view addSubview:tfView1];

        if (i == 2) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = tfView1.nameTextField.frame;
            [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
            [tfView1 addSubview:button];
        }
    }

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 4*60 + 40, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    confirmButton.titleLabel.font = HGfont(18);
    [self.view addSubview:confirmButton];
}

-(void)confirmButtonClick
{


    if ([_naviStr isEqualToString:@"编辑地址"]) {

        UITextField *textField1 = [self.view viewWithTag:1000];
        UITextField *textField2 = [self.view viewWithTag:1001];
        UITextField *textField3 = [self.view viewWithTag:1002];
        UITextField *textField4 = [self.view viewWithTag:1003];

        if ([textField1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入收货人姓名"];
            return;
        }
        if ([textField2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择省市区"];
            return;
        }
        if ([textField4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入详细地址"];
            return;
        }

        TLNetworking *http = [TLNetworking new];
        http.code = ModifyReceiverAddressURL;
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
        http.parameters[@"addressee"] = textField1.text;
        http.parameters[@"isDefault"] = @"1";
        http.parameters[@"mobile"] = textField2.text;
        http.parameters[@"detail"] = textField4.text;
        http.parameters[@"province"] = _province;
        http.parameters[@"area"] = _area;
        http.parameters[@"city"] = _city;
        http.parameters[@"code"] = _model.code;

        [http postWithSuccess:^(id responseObject) {
            WGLog(@"%@",responseObject);
            [self CreateNotification];
            [TLAlert alertWithSucces:@"修改成功"];
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

        if ([textField1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入收货人姓名"];
            return;
        }
        if ([textField2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择省市区"];
            return;
        }
        if ([textField4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入详细地址"];
            return;
        }

        TLNetworking *http = [TLNetworking new];
        http.code = AddShippingAddressURL;
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
        http.parameters[@"addressee"] = textField1.text;
        http.parameters[@"isDefault"] = @"2";
        http.parameters[@"mobile"] = textField2.text;
        http.parameters[@"detail"] = textField4.text;
        http.parameters[@"province"] = _province;
        http.parameters[@"area"] = _area;
        http.parameters[@"city"] = _city;

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

-(void)CreateNotification
{
    // 2.创建通知
    NSNotification *notification =[NSNotification notificationWithName:AddressPageLoadData object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)buttonClick
{
    [self.view endEditing:YES];
    [self.pickerView show];
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.pickerView show];
    }else{
        [self.pickerView hide];
    }
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self btnClick:_addressBtn];
}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{

    [self btnClick:_addressBtn];
    UITextField *textField = [self.view viewWithTag:1002];
    textField.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    _province = province;
    _city = city;
    _area = area;
}



@end
