//
//  MessageTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "MessageModel.h"
@interface MessageTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <MessageModel *>*model;

@end
