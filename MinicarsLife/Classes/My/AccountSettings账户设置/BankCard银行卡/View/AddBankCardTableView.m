//
//  AddBankCardTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AddBankCardTableView.h"
#import "AddBankCardCell.h"
#define AddBankCard @"AddBankCardCell"
@interface AddBankCardTableView ()<UITableViewDelegate,UITableViewDataSource
>
{
    BankCardModel *bankModel;
    NSArray *dataArray;
}


@end
@implementation AddBankCardTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AddBankCardCell class] forCellReuseIdentifier:AddBankCard];
    }

    return self;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
}

-(void)setArray:(NSArray *)array
{
    NSLog(@"%@",array);
    if (array.count > 0) {
        dataArray = array;
        [self reloadData];
    }
}


#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:AddBankCard forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"持卡人",@"手机号码",@"银行",@"开户支行",@"卡号"];
    NSArray *placeholderArray = @[@"请输入姓名",@"请输入手机号码",@"请选择银行",@"请输入开户支行",@"请输入银行卡号"];
    cell.nameLabel.text = nameArray[indexPath.row];
    cell.nameTextField.placeholder = placeholderArray[indexPath.row];
    cell.nameTextField.tag = 1000+indexPath.row;
    if (dataArray.count > 0) {
        cell.nameTextField.text = dataArray[indexPath.row];
    }
    if (indexPath.row == 1) {
        cell.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    if (indexPath.row == 2)
    {
        cell.button.hidden= NO;
        cell.xiaImage.hidden = NO;
        [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.button.tag = 100;
    }else
    {
        cell.button.hidden= YES;
        cell.xiaImage.hidden = YES;

    }
    return cell;

}



#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    confirmButton.titleLabel.font = HGfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    confirmButton.tag = 101;
    [headView addSubview:confirmButton];

    UILabel *label = [UILabel labelWithFrame:CGRectMake(20, 110, SCREEN_WIDTH - 40, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor redColor]];
    label.text = @"请仔细核对银行信息，确保银行账户有效，以免耽误资金使用。";
    label.numberOfLines = 0;
    [label sizeToFit];
    [headView addSubview:label];

    return headView;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)buttonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

@end
