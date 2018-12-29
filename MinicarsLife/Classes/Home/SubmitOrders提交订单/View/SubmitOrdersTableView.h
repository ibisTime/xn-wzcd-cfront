//
//  SubmitOrdersTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AddressModel.h"
#import "BankCardModel.h"
#import "HomeModel.h"
@interface SubmitOrdersTableView : TLTableView


@property(nonatomic , strong)AddressModel *addressModel;
@property(nonatomic , strong)BankCardModel *bankCardModel;
@property(nonatomic , strong)HomeModel *homeModel;

@property(nonatomic , copy)NSString *specificationsStr;
@end
