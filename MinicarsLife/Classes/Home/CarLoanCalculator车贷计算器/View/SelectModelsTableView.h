//
//  SelectModelsTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "ExhibitionCenterModel.h"
@interface SelectModelsTableView : TLTableView

@property (nonatomic, strong) NSMutableArray <ExhibitionCenterModel *>*model;

@end
