//
//  CarLoanCalculatorModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@interface CarLoanCalculatorModel : TLTableView

@property (nonatomic , copy)NSString *cvalue;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *CarId;
@property (nonatomic , copy)NSString *ckey;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *updater;


@end
