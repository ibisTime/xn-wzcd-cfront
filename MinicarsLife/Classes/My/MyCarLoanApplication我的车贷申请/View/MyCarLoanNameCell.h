//
//  MyCarLoanNameCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarLoansModel.h"
@interface MyCarLoanNameCell : UITableViewCell

@property (nonatomic , strong)CarLoansModel *model;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *detailedLabel;

@end
