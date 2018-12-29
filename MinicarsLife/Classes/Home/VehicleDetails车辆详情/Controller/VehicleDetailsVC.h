//
//  VehicleDetailsVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
//#import "VehicleDetailsModel.h"
#import "ExhibitionCenterModel.h"
@interface VehicleDetailsVC : BaseViewController

@property (nonatomic , copy)NSString *code;
@property (nonatomic , strong)ExhibitionCenterModel *model;
@end
