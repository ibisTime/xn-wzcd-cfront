//
//  CreditReportTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/10.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CreditReportModel.h"
@interface CreditReportTableView : TLTableView
@property (nonatomic, strong) NSMutableArray <CreditReportModel *>*model;

@property (nonatomic , copy)NSString *amount;


@end
