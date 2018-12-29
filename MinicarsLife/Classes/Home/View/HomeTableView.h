//
//  HomeTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "HomeModel.h"
@interface HomeTableView : TLTableView
@property (nonatomic, strong) NSMutableArray <HomeModel *>*carModel;
@property (nonatomic, strong) NSMutableArray <HomeModel *>*goodsModel;

@property (nonatomic , strong)NSArray *bannerArray;
@end
