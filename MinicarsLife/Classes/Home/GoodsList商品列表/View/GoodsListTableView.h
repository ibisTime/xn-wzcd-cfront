//
//  GoodsListTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "HomeModel.h"
@interface GoodsListTableView : TLTableView

@property (nonatomic, strong) NSMutableArray <HomeModel *>*goodsModel;

@end
