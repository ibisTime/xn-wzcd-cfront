//
//  TheBalanceOfTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TheBalanceOfTableView.h"
#import "TheBalanceOfCell.h"
#define TheBalanceOf @"TheBalanceOfCell"
@interface TheBalanceOfTableView ()<UITableViewDelegate,UITableViewDataSource
>
{
    UIView *headView;
    UILabel *nameLabel;
    UILabel *numberLabel;

}

@end

@implementation TheBalanceOfTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TheBalanceOfCell class] forCellReuseIdentifier:TheBalanceOf];
        [self TheInterfaceDisplayView];
    }

    return self;
}

-(void)TheInterfaceDisplayView
{

    headView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headView.backgroundColor = MainColor;
    [self addSubview:headView];

    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26.5, SCREEN_WIDTH, 15)];
    nameLabel.text = @"账户余额(元)";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = HGColor(255, 255, 255);
    nameLabel.font = HGfont(15);
    [headView addSubview:nameLabel];

    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41.5+15, SCREEN_WIDTH, 45)];
    
//    numberLabel.text = [NSString stringWithFormat:@"%.2f",[self.model.amount floatValue]/1000];


    numberLabel.textColor = HGColor(255, 255, 255);
    numberLabel.font = HGfont(45);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:numberLabel];
    self.tableHeaderView = headView;

}

-(void)setModel:(AccountModel *)model
{
    numberLabel.text = [NSString stringWithFormat:@"%.2f",[model.amount floatValue]/1000];
}



#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheBalanceOfCell *cell = [tableView dequeueReusableCellWithIdentifier:TheBalanceOf forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"消费金额",@"充值金额",@"提现金额"];
    cell.nameLbl.text = nameArray[indexPath.row];
    NSLog(@"%@",self.model.currency);
    NSArray *moneyArray = @[[NSString stringWithFormat:@"¥%.2f",[self.model.outAmount floatValue]/1000],[NSString stringWithFormat:@"¥%.2f",[self.model.inAmount floatValue]/1000],[NSString stringWithFormat:@"¥%.2f",[self.model.outAmount floatValue]/1000]];
    cell.moneyLbl.text = moneyArray[indexPath.row];
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
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
