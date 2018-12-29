//
//  ExhibitionCenterModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitionCenterModel : NSObject

//图文详情
@property (nonatomic, copy) NSString *desc;

@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *seriesName;
@property (nonatomic , copy)NSString *sfAmount;
@property (nonatomic , copy)NSString *slogan;
@property (nonatomic , copy)NSString *updaterName;
@property (nonatomic , copy)NSString *seriesCode;
@property (nonatomic , copy)NSString *advPic;
@property (nonatomic , copy)NSString *pic;
@property (nonatomic , strong)NSArray *pics;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *salePrice;
@property (nonatomic , copy)NSString *location;
@property (nonatomic , copy)NSString *orderNo;
@property (nonatomic , copy)NSString *updater;
@property (nonatomic , copy)NSString *brandCode;
@property (nonatomic , copy)NSString *brandName;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *name;



@end
