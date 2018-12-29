//
//  AccountSettingsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccountSettingsVC.h"
#import "AccountSettingsCell.h"
//修改昵称
#import "NickNameVC.h"
//修改手机号
#import "ModifyPhoneVC.h"
//修改密码
#import "ChangePasswordVC.h"
//修改支付密码
#import "ModifyayPasswordVC.h"
//收货地址
#import "ShippingAddressVC.h"
//银行卡
#import "BankCardVC.h"
#define AccountSettings @"AccountSettingsCell"

#import "TLUploadManager.h"
@interface AccountSettingsVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate
>
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation AccountSettingsVC

#pragma mark -- tableView懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame;
        NSLog(@"%d",kStatusBarHeight);
        tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AccountSettingsCell class] forCellReuseIdentifier:AccountSettings];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户设置";
    [self.view addSubview:self.tableView];
    //    [self.view addSubview:self.exitButton];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 2;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountSettings forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"头像";
                if ([USERXX isBlankString:[USERDEFAULTS objectForKey:PHOTO]] == NO) {
                    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[[USERDEFAULTS objectForKey:PHOTO] convertImageUrl]] placeholderImage:HGImage(@"myheadimage")];
                }else
                {
                    cell.headImage.image = HGImage(@"myheadimage");
                }
            }else
            {

                cell.nameLabel.text = @"昵称";
                cell.contactLabel.text = [USERDEFAULTS objectForKey:NICKNAME];
            }
        }
            break;
        case 1:
        {
            NSLog(@" ========= %@",[USERDEFAULTS objectForKey:PAYPASSWORD]);
            if ([[USERDEFAULTS objectForKey:PAYPASSWORD] integerValue] == 0) {
                NSArray *nameArray = @[@"修改手机号",@"修改登录密码",@"设置支付密码"];
                cell.nameLabel.text = nameArray[indexPath.row];
            }else
            {
                NSArray *nameArray = @[@"修改手机号",@"修改登录密码",@"修改支付密码"];
                cell.nameLabel.text = nameArray[indexPath.row];
            }

            if (indexPath.row == 0) {
                cell.contactLabel.text = [USERDEFAULTS objectForKey:MOBILE];
//                cell.contactLabel.hidden = NO;
            }
        }
            break;
        case 2:
        {
            NSArray *nameArray = @[@"收货地址",@"银行卡管理"];
            cell.nameLabel.text = nameArray[indexPath.row];
        }
            break;
        case 3:
        {
            cell.youImage.hidden = YES;
            cell.nameLabel.text = @"退出登录";
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
            if (indexPath.row == 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                    [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
                }];
                UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

                    //创建UIImagePickerController对象，并设置代理和可编辑
                    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.editing = YES;
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    //选择相机时，设置UIImagePickerController对象相关属性
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                    //跳转到UIImagePickerController控制器弹出相机
                    [self presentViewController:imagePicker animated:YES completion:nil];



                }];
                UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {


                    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.editing = YES;
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    //跳转到UIImagePickerController控制器弹出相册
                    [self presentViewController:imagePicker animated:YES completion:nil];

                }];
                [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
                [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
                [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
                [alertController addAction:cancelAction];
                [alertController addAction:fromPhotoAction];
                [alertController addAction:fromPhotoAction1];
                if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
                    alertController.popoverPresentationController.sourceView = self.view;
                    alertController.popoverPresentationController.sourceRect = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                }
                [self presentViewController:alertController animated:YES completion:nil];
            }
            if (indexPath.row == 1) {
                NickNameVC *vc = [[NickNameVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                ModifyPhoneVC *vc = [[ModifyPhoneVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 1) {
                ChangePasswordVC *vc = [[ChangePasswordVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 2) {
                ModifyayPasswordVC *vc = [[ModifyayPasswordVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                ShippingAddressVC *vc = [[ShippingAddressVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 1) {
                BankCardVC *vc = [[BankCardVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 3:
        {

            [TLAlert alertWithTitle:@"提示" msg:@"是否退出登录" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
                LoginViewController *vc = [[LoginViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                vc.state = @"100";
                [USERDEFAULTS removeObjectForKey:USER_ID];
                [USERDEFAULTS removeObjectForKey:TOKEN_ID];
                [rootViewController presentViewController:nav animated:YES completion:nil];
            } confirm:^(UIAlertAction *action) {

            }];

        }
            break;

        default:
            break;
    }

}

#pragma mark -- 获取图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    MinicarsLifeWeakSelf;
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    manager.imgData = imgData;
    manager.image = image;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {

        [weakSelf changeHeadIconWithKey:key imgData:imgData];

    } failure:^(NSError *error) {

    }];


}

- (void)changeHeadIconWithKey:(NSString *)key imgData:(NSData *)imgData {

    TLNetworking *http = [TLNetworking new];

    http.showView = self.view;
    http.code = @"805080";
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"photo"] = key;
    http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
    [http postWithSuccess:^(id responseObject) {

        [TLAlert alertWithSucces:@"修改头像成功"];

        [USERDEFAULTS setObject:key forKey:PHOTO];
        [self.tableView reloadData];


    } failure:^(NSError *error) {


    }];

    

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
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
        [weakSelf.tableView reloadData];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}



@end
