//
//  AboutUsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/16.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()
{
    UIWebView *_webView;
}

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _titleStr;
    [self LoadData];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - kNavigationBarHeight)];
//    _webView.delegate = self;
    _webView.scrollView.bounces=NO;
    [self.view addSubview:_webView];
}

-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630047";
    http.showView = self.view;
    http.parameters[@"key"] = _ckey;


    [http postWithSuccess:^(id responseObject) {
        [_webView loadHTMLString:responseObject[@"data"][@"cvalue"] baseURL:nil];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

@end
