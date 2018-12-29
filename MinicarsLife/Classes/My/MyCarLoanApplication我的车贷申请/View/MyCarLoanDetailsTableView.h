//
//  MyCarLoanDetailsTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarLoansModel.h"
@interface MyCarLoanDetailsTableView : TLTableView

@property (nonatomic , strong)CarLoansModel *model;

@property (nonatomic , strong)NSArray *priceArray;

@end
