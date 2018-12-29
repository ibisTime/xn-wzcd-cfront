//
//  HomeTableView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeHeaderView.h"
#import "HomeRecommendedModelsCell.h"
#import "HomeInstallmentGoodsCell.h"

#define MODELSCELL @"modelscell"
#define INSTALLMENTCELL @"Installmentcell"

@interface HomeTableView()<UITableViewDelegate, UITableViewDataSource,HomeRecommendedModelsDelegate>
@property (nonatomic , strong)HW3DBannerView *scrollView;
@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.tableHeaderView = self.scrollView;
        [self registerClass:[HomeRecommendedModelsCell class] forCellReuseIdentifier:MODELSCELL];
        [self registerClass:[HomeInstallmentGoodsCell class] forCellReuseIdentifier:INSTALLMENTCELL];
    }

    return self;
}


#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.userInteractionEnabled=YES;
        _scrollView.autoScrollTimeInterval = 3;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片

        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            NSLog(@"%ld",currentIndex);
            //            _currentIndex = currentIndex;
        };
        //        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)setBannerArray:(NSArray *)bannerArray
{
    _scrollView.data = bannerArray;
    [self reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.goodsModel.count;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HomeRecommendedModelsCell *cell = [tableView dequeueReusableCellWithIdentifier:MODELSCELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (self.carModel.count > 0) {
            cell.Model = self.carModel;
        }

        return cell;
    }
    HomeInstallmentGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:INSTALLMENTCELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.goodsModel.count > 0) {
        cell.Model = self.goodsModel[indexPath.row];
    }
    return cell;

}

-(void)HomeRecommendedModelsButton:(NSInteger)tag button:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:tag];
    }
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
    if (indexPath.section == 0) {
        return 20 + (SCREEN_WIDTH - 40)/3/3 *2 + 20 + 35;
    }
    return 115;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 35;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    static NSString *HeaderID = @"MyHeader";
    HomeHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];

    if (header == nil) {
        //        NSLog(@"实例化标题栏");
        header = [[HomeHeaderView alloc]initWithReuseIdentifier:HeaderID];
    }
    //    header.delegate = self;
    NSArray *nameArray = @[@"推荐车型",@"推荐分期"];
    [header.contentView setBackgroundColor:[UIColor whiteColor]];
    [header.headerButton setTitle:nameArray[section] forState:(UIControlStateNormal)];
    [header.headerButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"recommended%ld",(long)section]] forState:(UIControlStateNormal)];
    }];
    if (section == 0)
    {
        header.calculateButton.hidden = NO;
        header.youImage.hidden = YES;
    }else
    {
        header.calculateButton.hidden = YES;
        header.youImage.hidden = NO;
    }
    [header.headerButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    header.headerButton.tag = 98 + section;
    [header.calculateButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    header.calculateButton.tag = 98 + section;


    return header;
}

-(void)headerButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
