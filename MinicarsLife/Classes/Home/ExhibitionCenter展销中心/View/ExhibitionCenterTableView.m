//
//  ExhibitionCenterTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ExhibitionCenterTableView.h"
#import "ExhibitionCenterCell.h"
#import "VehicleDetailsVC.h"

#define ExhibitionCenter @"ExhibitionCenterCell"

@interface ExhibitionCenterTableView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
>
{
    UISearchBar * bar;
    BOOL _isSearch;
}
@end

@implementation ExhibitionCenterTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ExhibitionCenterCell class] forCellReuseIdentifier:ExhibitionCenter];
        [self headUISearchBarView];
    }

    return self;
}

-(void)headUISearchBarView
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, 60)];
    backView.backgroundColor = BackColor;
    self.tableHeaderView = backView;

    bar= [[UISearchBar alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40 , 40)];
    bar.layer.masksToBounds = YES;
    bar.layer.cornerRadius = 20;
    bar.placeholder = @"请输入您感兴趣的商品";
    bar.delegate = self;
    bar.backgroundColor = [UIColor whiteColor];
    [bar setBackgroundImage:[UIImage new]];
    [bar setTranslucent:YES];
    bar.delegate = self;
    UITextField * searchField = [bar valueForKey:@"_searchField"];
    [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchField.font = HGfont(14);
    _isSearch = NO;
    [backView addSubview:bar];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //取消搜索状态
    _isSearch = NO;
    [bar resignFirstResponder];
    [self reloadData];

}
//当搜索框中的文本发生变化时
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    [self filterBySubstring:searchText];
//}
//当用户点击虚拟键盘上的search按钮时激发该方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterBySubstring:searchBar.text];
    [bar resignFirstResponder];
}
-(void)filterBySubstring:(NSString *)subStr
{
    if (subStr.length == 0) {
        _isSearch = NO;
    }else
    {
        //设置搜索状态
        _isSearch = YES;
    }
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:BarName:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self BarName:subStr];
    }
    //让表格控件重新加载数据
    [self reloadData];
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ExhibitionCenter forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.Model = self.model[indexPath.row];
    }
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
    return 110;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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



@end
