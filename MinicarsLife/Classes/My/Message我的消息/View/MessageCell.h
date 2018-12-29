//
//  MessageCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageCell : UITableViewCell

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *contentLabel;

@property (nonatomic , strong)MessageModel *model;

@end
