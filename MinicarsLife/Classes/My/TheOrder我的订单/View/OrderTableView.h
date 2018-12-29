//
//  OrderTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "OrderModel.h"
@interface OrderTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <OrderModel*>*model; 

@end
