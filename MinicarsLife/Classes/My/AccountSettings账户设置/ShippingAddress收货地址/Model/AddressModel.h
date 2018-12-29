//
//  AddressModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
//收件人
@property (nonatomic , copy)NSString *addressee;

@property (nonatomic , copy)NSString *area;

@property (nonatomic , copy)NSString *city;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *detail;

@property (nonatomic , copy)NSString *isDefault;

@property (nonatomic , copy)NSString *mobile;

@property (nonatomic , copy)NSString *province;

@property (nonatomic , copy)NSString *userId;


@end
