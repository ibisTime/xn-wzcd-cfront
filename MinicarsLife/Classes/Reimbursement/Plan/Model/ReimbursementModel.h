//
//  ReimbursementModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReimbursementModel : NSObject

@property (nonatomic , assign)NSInteger refType;

@property (nonatomic  , assign)CGFloat restAmount;

@property (nonatomic , strong)NSDictionary *budgetOrder;

@property (nonatomic , copy)NSString *firstRepayDatetime;

@property (nonatomic , copy)NSString *loanEndDatetime;

@property (nonatomic , strong)NSArray *repayPlanList;

@property (nonatomic , copy)NSString *loanAmount;

@property (nonatomic , copy)NSString *loanBalance;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , strong)NSDictionary *mallOrder;

@property (nonatomic , copy)NSString *curNodeCode;

@end
