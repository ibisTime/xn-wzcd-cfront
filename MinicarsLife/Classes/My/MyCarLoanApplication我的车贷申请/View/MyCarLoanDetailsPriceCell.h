//
//  MyCarLoanDetailsPriceCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarLoansModel.h"
@interface MyCarLoanDetailsPriceCell : UITableViewCell

@property (nonatomic , strong)NSArray *array;

@property (nonatomic , strong)CarLoansModel *model;

@property (nonatomic , strong)UILabel *allPriceLabel;

@property (nonatomic , strong)UILabel *priceLabel;


@end
