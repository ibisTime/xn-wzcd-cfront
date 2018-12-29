//
//  TheBalanceOfTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccountModel.h"
@interface TheBalanceOfTableView : TLTableView
@property (nonatomic , strong)AccountModel *model;
@end
