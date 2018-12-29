//
//  CreditReportModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditReportModel : NSObject


@property (nonatomic,copy)NSString *transAmountString;

@property (nonatomic,copy)NSString *accountNumber;//   账号    string    @mock=A2017051619221078131
@property (nonatomic,copy)NSString *adjustDatetime;//    调账时间    string    @mock=
@property (nonatomic,copy)NSString *adjustNote;//    调账说明    string    @mock=
@property (nonatomic,copy)NSString *adjustUser;//    调账人    string    @mock=
@property (nonatomic,copy)NSString *bizNote;//    业务类型    string    @mock=1
@property (nonatomic,copy)NSString *bizType;//    业务类型    string    @mock=01
@property (nonatomic,copy)NSString *channelOrder;//    支付渠道单号    string    @mock=
@property (nonatomic,copy)NSString *channelType;//    支付渠道类型    string    @mock=0
@property (nonatomic,copy)NSString *checkDatetime;//    对账时间    string    @mock=
@property (nonatomic,copy)NSString *checkNote;//    对账说明    string    @mock=
@property (nonatomic,copy)NSString *checkUser;//    对账人    string    @mock=
@property (nonatomic,copy)NSString *code;//    编号    string    @mock=AJ2017051620132097666
@property (nonatomic,copy)NSString *createDatetime;//    创建时间    string    @mock=May 16, 2017 8:13:20 PM
@property (nonatomic,copy)NSString *currency;//    币种    string    @mock=CNY
@property (nonatomic,copy)NSString *kind;//    流水类型    string    @mock=
@property (nonatomic,copy)NSString *payGroup;//    订单分组组号    string    @mock=
@property (nonatomic,copy)NSString *postAmount;//    变动后金额    number    @mock=99000
@property (nonatomic,copy)NSString *preAmount;//    变动前金额    number    @mock=100000
@property (nonatomic,copy)NSString *realName;//    真实姓名    string    @mock=李大侠
@property (nonatomic,copy)NSString *refNo;//    参考订单号    string    @mock=1
@property (nonatomic,copy)NSString *remark;//    备注    string    @mock=记得对账哦
@property (nonatomic,copy)NSString *status;//    状态    string    @mock=1
@property (nonatomic,copy)NSString *transAmount;//    变动金额    number    @mock=-1000
@property (nonatomic,copy)NSString *type;//    账户类型    string    @mock=
@property (nonatomic,copy)NSString *userId;//    用户编号    string    @mock=U2016122116231392740
@property (nonatomic,copy)NSString *workDate;//    拟对账时间

@end
