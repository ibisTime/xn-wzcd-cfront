//
//  CarLoanCalculatorHeadCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExhibitionCenterModel.h"

@interface CarLoanCalculatorHeadCell : UITableViewCell

@property (nonatomic , strong)UILabel *allPriceLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)ExhibitionCenterModel *carModel;

@end
