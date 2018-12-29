//
//  SubmitOrderAddressCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface SubmitOrderAddressCell : UITableViewCell

@property (nonatomic , strong)AddressModel *model;

@property (nonatomic , strong)UILabel *backLabel;

@property (nonatomic , strong)UIImageView *addressImg;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *addressLbl;

@property (nonatomic , strong)UILabel *phoneLbl;

@end
