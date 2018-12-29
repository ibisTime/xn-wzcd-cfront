//
//  HomeRecommendedModelsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeRecommendedModelsCell.h"
#define WIDTH (SCREEN_WIDTH - 40)/3

@implementation HomeRecommendedModelsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 40)/3/3 *2 + 70)];
        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 40)/3/3 *2 + 70  , SCREEN_WIDTH, 10)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

    }
    return self;
}

-(void)backButtonClick:(UIButton *)sender
{
    [_delegate HomeRecommendedModelsButton:sender.tag button:sender];
}

-(void)setModel:(NSMutableArray<HomeModel *> *)Model
{

    NSLog(@"%@",Model);
    for (int i = 0; i < Model.count; i ++) {


        HomeModel *mondel = Model[i];

        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.tag = i + 100;
        _backButton.frame = CGRectMake(i % Model.count * (SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3);
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_scrollView addSubview:_backButton];



        _carImage = [[UIImageView alloc]init];
        _carImage.frame = CGRectMake(10, 10, WIDTH, WIDTH/3 *2);
        [_carImage sd_setImageWithURL:[NSURL URLWithString:[mondel.advPic convertImageUrl]]];
        kViewRadius(_carImage, 5);
//        [_carImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",QINIUURL,mondel.advPic]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//            NSLog(@"错误信息:%@",error);
//
//        }];
//        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",QINIUURL,mondel.advPic]);
        [_backButton addSubview:_carImage];

        _nameLabel = [UILabel labelWithFrame:CGRectMake(10, 15 + WIDTH/3 *2, WIDTH, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:[UIColor whiteColor] font:HGfont(13) textColor:[UIColor blackColor]];

        [_backButton addSubview:_nameLabel];

        _priceLabel = [UILabel labelWithFrame:CGRectMake(10, 20 + WIDTH/3 *2 + 20, WIDTH, 20) textAligment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] font:HGfont(13) textColor:PriceColor];
        [_backButton addSubview:_priceLabel];


        _scrollView.contentSize = CGSizeMake(Model.count * SCREEN_WIDTH/3, (SCREEN_WIDTH - 40)/3/3 *2 + 70);
        _nameLabel.text = mondel.name;
        _priceLabel.text = [NSString stringWithFormat:@"首付:%.2f",[mondel.price floatValue] / 1000];

    }
}





@end
