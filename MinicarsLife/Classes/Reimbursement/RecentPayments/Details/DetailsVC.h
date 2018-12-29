//
//  DetailsVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "NearFutureModel.h"
@interface DetailsVC : BaseViewController



@property (nonatomic , strong)NearFutureModel *model;

@property (nonatomic , copy)NSString *code;

@end
