//
//  ExhibitionCenterCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExhibitionCenterModel.h"

@interface ExhibitionCenterCell : UITableViewCell

@property (nonatomic , strong)ExhibitionCenterModel *Model;

@property (nonatomic , strong)UIImageView *goodsImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *brandLabel;

@property (nonatomic , strong)UILabel *allPriceLabel;

@property (nonatomic , strong)UILabel *downPaymentLabel;

@end
