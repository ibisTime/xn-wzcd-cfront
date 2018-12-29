//
//  ReimbursementTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "ReimbursementModel.h"

@interface ReimbursementTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <ReimbursementModel *>*model;



@end
