//
//  TheDetailTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/16.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "TheDetailModel.h"
@interface TheDetailTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <TheDetailModel *>*model;
@end
