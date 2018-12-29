//
//  CarLoanCalculatorVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "ExhibitionCenterModel.h"
@interface CarLoanCalculatorVC : BaseViewController

@property (nonatomic , strong)ExhibitionCenterModel *carModel;
@property (nonatomic , copy)NSString *state;

@end
