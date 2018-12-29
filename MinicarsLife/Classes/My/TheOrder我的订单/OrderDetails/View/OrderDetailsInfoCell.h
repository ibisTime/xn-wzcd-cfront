//
//  OrderDetailsInfoCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderDetailsInfoCell : UITableViewCell

@property (nonatomic , strong)OrderModel *model;

@property (nonatomic , strong)UILabel *nameLabel;

@end
