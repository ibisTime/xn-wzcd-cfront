//
//  IntroductionCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionCenterModel.h"
#import "HomeModel.h"
@interface IntroductionCell : UITableViewCell

@property (nonatomic , strong)ExhibitionCenterModel *model;
@property (nonatomic , strong)HomeModel *homemodel;
@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UILabel *referencePriceLabel;

@end
