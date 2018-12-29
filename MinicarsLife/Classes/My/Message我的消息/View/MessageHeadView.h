//
//  MessageHeadView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageModel.h"

@interface MessageHeadView : UITableViewHeaderFooterView

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)MessageModel *model;

@end
