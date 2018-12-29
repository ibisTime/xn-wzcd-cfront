//
//  EditorAddressVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
@interface EditorAddressVC : BaseViewController

@property (nonatomic , copy)NSString *naviStr;

@property (nonatomic , strong)AddressModel *model;

@end
