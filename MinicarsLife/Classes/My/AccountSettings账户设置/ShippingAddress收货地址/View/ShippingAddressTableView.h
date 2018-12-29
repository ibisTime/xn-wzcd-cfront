//
//  ShippingAddressTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AddressModel.h"
@interface ShippingAddressTableView : TLTableView

@property (nonatomic, strong) NSMutableArray <AddressModel *>*model;

@end
