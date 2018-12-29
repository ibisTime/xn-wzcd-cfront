//
//  MessageTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageHeadView.h"
#import "MessageCell.h"

#define Message @"MessageCell"
@interface MessageTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    MessageCell *cell;
}
@end
@implementation MessageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MessageCell class] forCellReuseIdentifier:Message];
    }

    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:Message forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (_model.count > 0) {
        cell.model = _model[indexPath.section];
    }
    return cell;

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + cell.contentLabel.frame.size.height;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderID = @"MyHeader";
    MessageHeadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];

    if (header == nil) {
        //        NSLog(@"实例化标题栏");
        header = [[MessageHeadView alloc]initWithReuseIdentifier:HeaderID];

    }
    if (_model.count > 0) {
        header.model = _model[section];
    }
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
