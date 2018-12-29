//
//  RecordCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReimbursementModel.h"
#import "NearFutureModel.h"
@interface RecordCell : UITableViewCell
@property (nonatomic , strong)ReimbursementModel *model;
@property (nonatomic , strong)NearFutureModel *model1;
@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *stateLabel;



@end
