//
//  GoodsDetailsViewController.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "ChooseView.h"
#import "ChooseRank.h"
#import "HomeModel.h"
@interface GoodsDetailsViewController : BaseViewController

@property(nonatomic,strong)ChooseView *chooseView;
@property(nonatomic,strong)ChooseRank *chooseRank;
@property(nonatomic,strong)NSMutableArray *rankArray;

@property (nonatomic,strong)HomeModel *model;

@end
