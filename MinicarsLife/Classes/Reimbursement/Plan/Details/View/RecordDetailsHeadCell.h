//
//  RecordDetailsHeadCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReimbursementModel.h"
#import "NearFutureModel.h"
@interface RecordDetailsHeadCell : UITableViewCell

@property (nonatomic , strong)ReimbursementModel *model;

@property (nonatomic , strong)NearFutureModel *model1;

@end
