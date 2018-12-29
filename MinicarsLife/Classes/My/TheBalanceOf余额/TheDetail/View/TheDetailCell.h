//
//  TheDetailCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheDetailModel.h"
@interface TheDetailCell : UITableViewCell

@property (nonatomic , strong)TheDetailModel *model;

@property (nonatomic , strong)UILabel *dayLbl;

@property (nonatomic , strong)UILabel *whenLbl;

@property (nonatomic , strong)UIImageView *stateImg;

@property (nonatomic , strong)UILabel *moneyLbl;

@property (nonatomic , strong)UILabel *useLbl;


@end
