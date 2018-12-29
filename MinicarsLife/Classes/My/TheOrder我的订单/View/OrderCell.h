//
//  OrderCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderCell : UITableViewCell

@property (nonatomic , strong)OrderModel *model;

@property (nonatomic , strong)UILabel *SerialNumberLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UIImageView *goodsImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *introduceLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UILabel *numberLabel;

@property (nonatomic , strong)UIButton *cancelButton;

@property (nonatomic , strong)UIButton *ContinueButton;

@end
