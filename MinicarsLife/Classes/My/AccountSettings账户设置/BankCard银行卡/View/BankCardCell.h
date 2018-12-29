//
//  BankCardCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"
@interface BankCardCell : UITableViewCell
@property (nonatomic , strong)BankCardModel *model;

@property (nonatomic , strong)UIImageView *iconImage;

@property (nonatomic , strong)UIImageView *cardImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *numberLabel;

@end
