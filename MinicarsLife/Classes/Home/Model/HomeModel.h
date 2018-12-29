//
//  HomeModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic , copy)NSString *seriesCode;

//广告图
@property (nonatomic , copy)NSString *advPic;

@property (nonatomic , strong)NSArray *pics;

@property (nonatomic , copy)NSString *pic;
//    品牌编号
@property (nonatomic , copy)NSString *brandCode;
//编号
@property (nonatomic , copy)NSString *code;
//名称
@property (nonatomic , copy)NSString *name;
//价格
@property (nonatomic , copy)NSString *price;
//    备注
@property (nonatomic , copy)NSString *remark;
//广告语
@property (nonatomic , copy)NSString *slogan;
//状态
@property (nonatomic , copy)NSString *status;
//最新修改时间
@property (nonatomic , copy)NSString *updateDatetime;
//最新修改人
@property (nonatomic , copy)NSString *updater;

@property (nonatomic , copy)NSString *monthAmount;

@property (nonatomic , strong)NSArray *productSpecsList;

@property (nonatomic , copy)NSString *desc;

@end
