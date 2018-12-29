//
//  OrderModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic , copy)NSString *yunfei;
@property (nonatomic , copy)NSString *sfRate;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *amount;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , strong)NSArray *productOrderList;
@property (nonatomic , copy)NSString *reMobile;
@property (nonatomic , copy)NSString *loanAmount;
@property (nonatomic , copy)NSString *payAmount;
@property (nonatomic , strong)NSDictionary *user;
@property (nonatomic , copy)NSString *bankcardCode;
@property (nonatomic , copy)NSString *reAddress;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , copy)NSString *receiver;
@property (nonatomic , copy)NSString *applyUser;
@property (nonatomic , copy)NSString *bankRate;
@property (nonatomic , copy)NSString *sfAmount;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *periods;



@end
