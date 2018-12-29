//
//  GoodsDetailsViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "IntroductionCell.h"
#import "GoodsDetailsBottomView.h"
//提交订单
#import "SubmitOrdersVC.h"
#define Introduction @"IntroductionCell"
@interface GoodsDetailsViewController ()<UITableViewDelegate,UITableViewDataSource
,ChooseRankDelegate,UIWebViewDelegate>
{
    IntroductionCell *cell;
    UIView *backView;
    UIWebView *_webView;
    CGFloat webViewHeight;
}

//@property(nonatomic,strong)UIView *backgroundView;

@property(nonatomic,strong)NSArray *standardList;
@property(nonatomic,strong)NSArray *standardValueList;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)HW3DBannerView *scrollView;
@property (nonatomic , strong)GoodsDetailsBottomView *BottomView;

@end

@implementation GoodsDetailsViewController

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[IntroductionCell class] forCellReuseIdentifier:Introduction];


    }
    return _tableView;
}

-(GoodsDetailsBottomView *)BottomView
{
    if (!_BottomView) {
        _BottomView = [[GoodsDetailsBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50, SCREEN_WIDTH, 50)];
        [_BottomView.shoppingButton addTarget:self action:@selector(chooseViewClick) forControlEvents:(UIControlEventTouchUpInside)];

        _BottomView.textDic = self.model.productSpecsList[0];
        
    }
    return _BottomView;
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
        _scrollView.data = _model.pics;
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            NSLog(@"%ld",currentIndex);
            //            _currentIndex = currentIndex;
        };
        //        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.title = @"商品详情";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.scrollView;
    [self.view addSubview:self.BottomView];

    NSArray *array = self.model.productSpecsList;
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        [array1 addObject:array[i][@"name"]];
    }
    self.standardList = @[@"规格"];
    self.standardValueList = @[array1];
    [self initChooseView];
}

-(void)initChooseView{

    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - kNavigationBarHeight)];
    backView.backgroundColor = [UIColor grayColor];
    backView.alpha = 0;
    [self.view addSubview:backView];

    self.chooseView = [[ChooseView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];

    [self.chooseView.headImage sd_setImageWithURL:[NSURL URLWithString:[self.model.pic convertImageUrl]]];
    self.chooseView.LB_price.text = self.model.name;
//    self.chooseView.LB_stock.text = @"有货";
    self.chooseView.LB_detail.text = [NSString stringWithFormat:@"¥%.2f ",[self.model.price floatValue]/1000];
    [self textDic:self.model.productSpecsList[0]];
    [self.view addSubview:self.chooseView];

    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++)
    {

        self.chooseRank = [[ChooseRank alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 40)];
        
        maxY = CGRectGetMaxY(self.chooseRank.frame);
        height += self.chooseRank.height;
        self.chooseRank.tag = 8000+i;
        self.chooseRank.delegate = self;

        [self.chooseView.mainscrollview addSubview:self.chooseRank];
    }
    self.chooseView.mainscrollview.contentSize = CGSizeMake(0, height);

    //立即购买
    [self.chooseView.buyBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    [self.chooseView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

    //点击黑色透明视图choseView会消失
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    [backView addGestureRecognizer:tap];
    NSLog(@" ++++++++++++ %@",_model.desc);
}

-(void)textDic:(NSDictionary *)textDic
{
    NSString *str = [NSString stringWithFormat:@"月供: %.2fx%@期",[textDic[@"monthAmount"] floatValue]/1000,textDic[@"periods"]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:GaryTextColor
                    range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MainColor
                    range:NSMakeRange(3, str.length - 3)];
    NSLog(@"%@",str);
    self.chooseView.MonthlyPaymentsLabel.attributedText = attrStr;
    self.chooseView.LB_detail.text = [NSString stringWithFormat:@"%.2f",[textDic[@"price"] floatValue]/1000];
}

#pragma mark --立即购买
-(void)addGoodsCartBtnClick{
    NSLog(@"立即购买");
    if([USERXX user].isLogin == NO) {
        [TLAlert alertWithTitle:@"提示" msg:@"您还未登陆,是否前去登陆" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {

            LoginViewController *vc = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [rootViewController presentViewController:nav animated:YES completion:nil];

        } confirm:^(UIAlertAction *action) {

        }];
    }else
    {
        if (self.rankArray.count == self.standardList.count) {
            SubmitOrdersVC *vc = [[SubmitOrdersVC alloc]init];
            vc.model = self.model;
            vc.selectArray = self.rankArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            [TLAlert alertWithInfo:@"请选择规格"];
        }
    }


}

-(void)chooseViewClick{
    [UIView animateWithDuration: 0.3 animations: ^{
        self.chooseView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        backView.alpha = 0.3;
    } completion: nil];

}

/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

-(void)dismiss
{
    [UIView animateWithDuration: 0.3 animations: ^{
        self.chooseView.frame =CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        backView.alpha = 0;
    } completion: nil];

}
-(NSMutableArray *)rankArray{

    if (_rankArray == nil) {

        _rankArray = [[NSMutableArray alloc] init];
    }
    return _rankArray;
}

//
-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{

    [self.rankArray removeAllObjects];

    for (int i=0; i < _standardList.count; i++)
    {
        ChooseRank *view = [self.view viewWithTag:8000+i];

        for (UIButton *obj in  view.btnView.subviews)
        {
            if(obj.selected){

                for (NSArray *arr in self.standardValueList)
                {
                    for (NSString *title in arr) {

                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {

                            [self.rankArray addObject:view.selectBtn.titleLabel.text];
                        }
                    }
                }
            }
        }
    }
    if (self.rankArray.count > 0) {
        for (int i = 0; i < _model.productSpecsList.count; i ++) {
            if ([self.rankArray[0] isEqualToString:self.model.productSpecsList[i][@"name"]]) {
                [self.chooseView.headImage sd_setImageWithURL:[NSURL URLWithString:[_model.productSpecsList[i][@"pic"] convertImageUrl]]];
                [self textDic:self.model.productSpecsList[i]];
                _BottomView.textDic = self.model.productSpecsList[i];
            }
        }
    }

    NSLog(@"%@",self.rankArray);
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
        cell.homemodel = self.model;
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
        [cell addSubview:_webView];

        [_webView loadHTMLString:strHTML baseURL:nil];


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



    [self.tableView reloadData];
}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return _webView.frame.size.height;
    }
    return cell.referencePriceLabel.frame.origin.y + cell.referencePriceLabel.frame.size.height + 10;
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
//    if (section == 0) {
//        return 10;
//    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 8, 3, 14)];
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
