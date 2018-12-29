//
//  VehicleDetailsTbaleView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "VehicleDetailsTbaleView.h"
#import "HW3DBannerView.h"
#import "IntroductionCell.h"

#define Introduction @"IntroductionCell"

@interface VehicleDetailsTbaleView ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate
>
{
    IntroductionCell *cell;
    UIWebView *_webView;
}

@property (nonatomic , strong)HW3DBannerView *scrollView;


@end

@implementation VehicleDetailsTbaleView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[IntroductionCell class] forCellReuseIdentifier:Introduction];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableHeaderView = self.scrollView;
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
        _scrollView.autoScroll = NO;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
        NSLog(@"%@",_model.pics);

        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            NSLog(@"%ld",currentIndex);
            //            _currentIndex = currentIndex;
        };
        //        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:Introduction forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([USERXX isBlankString:self.model.name] == NO) {
            cell.model = self.model;
            _scrollView.data = self.model.pics;
        }

        return cell;
    }

    static NSString *identifier = @"webCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSString *strHTML = self.model.desc;
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scrollView.bounces=NO;
        _webView.scalesPageToFit = YES;
        [_webView loadHTMLString:strHTML baseURL:nil];
        [cell addSubview:_webView];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;

}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    //HTML5的宽度
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    //宽高比
    float i = [htmlWidth floatValue]/[htmlHeight floatValue];

    //webview控件的最终高度
    float height = SCREEN_WIDTH/i;

    _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [self reloadData];
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSLog(@"%f",_webView.frame.size.width);
        NSLog(@"%f",_webView.frame.size.height);
        NSLog(@"%f",self.frame.size.width);
        NSLog(@"%f",self.frame.size.height);
        return _webView.frame.size.height;
    }
    return cell.referencePriceLabel.frame.origin.y + cell.referencePriceLabel.frame.size.height + 20;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, 3, 20)];
        lineView.backgroundColor = MainColor;
        [headView addSubview:lineView];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(33, 5, SCREEN_WIDTH - 33 - 15, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
        nameLabel.text = @"图文详情";
        [headView addSubview:nameLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
