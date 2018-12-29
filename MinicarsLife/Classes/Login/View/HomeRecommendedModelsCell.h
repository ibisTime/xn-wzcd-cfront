//
//  HomeRecommendedModelsCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRecommendedModelsCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic , strong)UIScrollView *scrollView;

@property (nonatomic , strong)UIButton *backButton;

@property (nonatomic , strong)UIImageView *carImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *priceLabel;



@end
