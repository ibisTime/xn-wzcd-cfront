//
//  CarLoansTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarLoansModel.h"
@interface CarLoansTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <CarLoansModel *>*model;

@end
