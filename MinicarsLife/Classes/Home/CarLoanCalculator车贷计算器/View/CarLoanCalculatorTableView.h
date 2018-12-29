//
//  CarLoanCalculatorTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "ExhibitionCenterModel.h"
#import "CarLoanCalculatorModel.h"
@interface CarLoanCalculatorTableView : TLTableView

@property (nonatomic , strong)ExhibitionCenterModel *carModel;

@property (nonatomic, strong) NSMutableArray <CarLoanCalculatorModel *>*model;

@property (nonatomic , copy)NSString *state;

@property (nonatomic , strong)NSArray *nameArray;

@property (nonatomic , strong)NSArray *priceArray;

@property (nonatomic , strong)NSArray *contactArray1;

@end
