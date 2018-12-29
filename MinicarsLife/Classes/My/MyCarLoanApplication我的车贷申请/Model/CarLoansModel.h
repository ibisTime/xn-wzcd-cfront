//
//  CarLoansModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLoansModel : NSObject



//"brandName" : "奥迪",
//"carCode" : "C201807101052402114992",
//"seriesName" : "奥迪A系",
//"carName" : "奥迪A8",
//"sfRate" : 0.30000000999999998,
//"sfAmount" : 330000,
//"periods" : 12,
//"seriesCode" : "S201807101050454147475",
//"code" : "COD201807102250180449994",
//"userId" : "U201807101016490582255",
//"price" : 1100000000,
//"createDatetime" : "Jul 10, 2018 10:50:18 PM",
//"userMobile" : "13506537519",
//"saleDesc" : "无",
//"status" : "0",
//"brandCode" : "B201807101043476945100"

@property (nonatomic , strong)NSString *brandName;
@property (nonatomic , strong)NSString *carCode;
@property (nonatomic , strong)NSString *seriesName;
@property (nonatomic , strong)NSString *carName;
@property (nonatomic , assign)CGFloat sfRate;
@property (nonatomic , assign)CGFloat sfAmount;
@property (nonatomic , strong)NSString *periods;
@property (nonatomic , strong)NSString *seriesCode;
@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *userId;
@property (nonatomic , strong)NSString *price;
@property (nonatomic , strong)NSString *createDatetime;
@property (nonatomic , strong)NSString *userMobile;
@property (nonatomic , strong)NSString *saleDesc;
@property (nonatomic , strong)NSString *status;
@property (nonatomic , strong)NSString *brandCode;


@property (nonatomic , strong)NSDictionary *car;


@end
