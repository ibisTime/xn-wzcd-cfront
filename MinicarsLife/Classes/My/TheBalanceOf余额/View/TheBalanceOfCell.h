//
//  TheBalanceOfCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
@interface TheBalanceOfCell : UITableViewCell

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *moneyLbl;

@property (nonatomic , strong)AccountModel *model;

@end
