//
//  CreditReportTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CreditReportTableView.h"
#import "CreditReportCell.h"

#define CreditReport @"CreditReportCell"

@interface CreditReportTableView ()<UITableViewDelegate,UITableViewDataSource
>
{
    UIView *headView;
    UILabel *nameLabel;
    UILabel *numberLabel;

}
@end

@implementation CreditReportTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CreditReportCell class] forCellReuseIdentifier:CreditReport];
        [self TheInterfaceDisplayView];
    }
    return self;


}

-(void)TheInterfaceDisplayView
{
    headView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
    headView.backgroundColor = MainColor;

    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26.5, SCREEN_WIDTH, 15)];
    nameLabel.text = @"当前信用分";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = HGColor(255, 255, 255);
    nameLabel.font = HGfont(15);
    [headView addSubview:nameLabel];

    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41.5+20, SCREEN_WIDTH, 32)];

    numberLabel.textColor = HGColor(255, 255, 255);
    numberLabel.font = HGfont(32);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:numberLabel];
    self.tableHeaderView = headView;

}

-(void)setAmount:(NSString *)amount
{
    numberLabel.text = [NSString stringWithFormat:@"%@",amount];
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreditReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CreditReport forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.model.count > 0) {
        cell.model = self.model[indexPath.row];
    }

    return cell;

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
