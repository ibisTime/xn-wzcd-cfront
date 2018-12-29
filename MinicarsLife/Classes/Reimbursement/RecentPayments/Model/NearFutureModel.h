//
//  NearFutureModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearFutureModel : NSObject


@property (nonatomic , copy)NSString *repayCapital;
@property (nonatomic , copy)NSString *curNodeCode;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *repayInterest;
@property (nonatomic , copy)NSString *isRepay;
@property (nonatomic , copy)NSString *repayDatetime;
@property (nonatomic , copy)NSString *curPeriods;
@property (nonatomic , copy)NSString *payedAmount;
@property (nonatomic , copy)NSString *overplusAmount;
@property (nonatomic , copy)NSString *shouldDeposit;
@property (nonatomic , strong)NSDictionary *repayBiz;
@property (nonatomic , copy)NSString *refType;
@property (nonatomic , copy)NSString *payedFee;
@property (nonatomic , copy)NSString *overdueDeposit;
@property (nonatomic , strong)NSDictionary *user;
@property (nonatomic , copy)NSString *repayAmount;
@property (nonatomic , copy)NSString *repayBizCode;
@property (nonatomic , copy)NSString *totalFee;
@property (nonatomic , copy)NSString *overdueAmount;
@property (nonatomic , copy)NSString *periods;
@property (nonatomic , copy)NSString *remindCount;
@property (nonatomic , copy)NSString *userId;


@end
