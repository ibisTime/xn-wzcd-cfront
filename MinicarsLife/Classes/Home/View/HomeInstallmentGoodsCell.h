//
//  HomeInstallmentGoodsCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeModel.h"

@interface HomeInstallmentGoodsCell : UITableViewCell

@property (nonatomic , strong)HomeModel *Model;

@property (nonatomic , strong)UIImageView *goodsImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UILabel *MonthlyPriceLabel;

@end
