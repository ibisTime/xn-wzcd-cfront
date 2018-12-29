//
//  SubmitOrdersTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrdersTableView.h"
#import "SubmitOrderAddressCell.h"
#import "SubmitOrderBankCardCell.h"
#import "SubmitOrderGoodsCell.h"
#define SubmitOrderAddress @"SubmitOrderAddressCell"
#define SubmitOrderBankCard @"SubmitOrderBankCardCell"
#define SubmitOrderGoods @"SubmitOrderGoodsCell"

@interface SubmitOrdersTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    SubmitOrderAddressCell *_cell;
    NSDictionary *dataDic;
}
@end

@implementation SubmitOrdersTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[SubmitOrderAddressCell class] forCellReuseIdentifier:SubmitOrderAddress];
        [self registerClass:[SubmitOrderBankCardCell class] forCellReuseIdentifier:SubmitOrderBankCard];
        [self registerClass:[SubmitOrderGoodsCell class] forCellReuseIdentifier:SubmitOrderGoods];




    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3)
    {
        return 5;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < _homeModel.productSpecsList.count; i ++) {
        if ([_homeModel.productSpecsList[i][@"name"] isEqualToString:self.specificationsStr]) {
            dataDic = _homeModel.productSpecsList[i];
        }
    }
    if(indexPath.section == 0)
    {
        _cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderAddress forIndexPath:indexPath];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([USERXX isBlankString:self.addressModel.addressee] == NO) {
            _cell.model = self.addressModel;
            _cell.backLabel.hidden = YES;
        }else
        {
            _cell.backLabel.hidden = NO;
        }
        return _cell;
    }
    if(indexPath.section == 1)
    {
        SubmitOrderBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderBankCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([USERXX isBlankString:self.bankCardModel.bankName] == NO) {
            cell.model = self.bankCardModel;
            cell.backLabel.hidden = YES;
        }else
        {
            cell.backLabel.hidden = NO;
        }
        return cell;
    }
    if(indexPath.section == 2)
    {
        SubmitOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOrderGoods forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.homeModel;
        if ([USERXX isBlankString:_specificationsStr] == NO) {
            cell.dic = dataDic;
        }
        return cell;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *textArray = @[@"首付比例",@"分期月数",@"分期利率",@"月供",@"首付"];

    NSString *str = @"%";
    NSArray *detailTextArray = @[
      [NSString stringWithFormat:@"%.1f%@",[dataDic[@"sfRate"] floatValue] * 100,str],
      [NSString stringWithFormat:@"%@",dataDic[@"periods"]],
      [NSString stringWithFormat:@"%.2f%@",[dataDic[@"bankRate"] floatValue]*100,str],
      [NSString stringWithFormat:@"%.2f",[dataDic[@"monthAmount"] floatValue]/1000],
      [NSString stringWithFormat:@"%.2f",[dataDic[@"price"] floatValue]/1000 * [dataDic[@"sfRate"] floatValue]]];
    cell.textLabel.text = textArray[indexPath.row];
    cell.textLabel.font = HGfont(14);
    cell.detailTextLabel.text = detailTextArray[indexPath.row];
    cell.detailTextLabel.font = HGfont(14);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LineBackColor;
    [cell addSubview:lineView];

    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if ([USERXX isBlankString:self.addressModel.addressee] == NO) {
            return 57 + _cell.addressLbl.frame.size.height;
        }else
        {
            return 50;
        }
    }
    if(indexPath.section == 1)
    {
        if ([USERXX isBlankString:self.bankCardModel.bankName] == NO) {
            return 95;
        }else
        {
            return 50;
        }

    }
    if(indexPath.section == 2)
    {
        return 110;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if(section == 0)
    {
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
    return nil;;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
