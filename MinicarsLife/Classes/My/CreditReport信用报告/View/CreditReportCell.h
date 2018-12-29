//
//  CreditReportCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditReportModel.h"
@interface CreditReportCell : UITableViewCell
@property (nonatomic , strong)CreditReportModel *model;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *numberLabel;

@end
