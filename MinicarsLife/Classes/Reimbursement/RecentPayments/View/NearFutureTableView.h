//
//  NearFutureTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "NearFutureModel.h"
@interface NearFutureTableView : TLTableView

//@property (nonatomic , strong)NSArray *listArray;

@property (nonatomic , strong)NSMutableArray <NearFutureModel *>*model;

@end
