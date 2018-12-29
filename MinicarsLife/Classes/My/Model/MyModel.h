//
//  MyModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
//账号
@property (nonatomic , copy)NSString *accountNumber;
//累计增加金额
@property (nonatomic , copy)NSString *addAmount;
//余额
@property (nonatomic , copy)NSString *amount;
//创建时间
@property (nonatomic , copy)NSString *createDatetime;
//币种
@property (nonatomic , copy)NSString *currency;
//冻结金额
@property (nonatomic , copy)NSString *frozenAmount;
//入金
@property (nonatomic , copy)NSString *inAmount;
//最近一次变动对应的流水编号
@property (nonatomic , copy)NSString *lastOrder;
@property (nonatomic , copy)NSString *md5;
//出金
@property (nonatomic , copy)NSString *outAmount;
//真实姓名
@property (nonatomic , copy)NSString *realName;
//状态
@property (nonatomic , copy)NSString *status;
//类别
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *userId;



@end
