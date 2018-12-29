//
//  CarLoanApplicationCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarLoansModel.h"
@interface CarLoanApplicationCell : UITableViewCell

@property (nonatomic , strong)CarLoansModel *model;

@property (nonatomic , strong)UILabel *SerialNumberLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UIImageView *carImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *introduceLabel;

@property (nonatomic , strong)UILabel *downPayLabel;


@end
