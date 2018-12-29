//
//  ShippingAddressCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol ShippingAddressCellDelegate <NSObject>

-(void)ShippingAddressCellButton:(NSInteger)tag button:(UIButton *)sender;

@end

@interface ShippingAddressCell : UITableViewCell

@property (nonatomic, assign) id <ShippingAddressCellDelegate> delegate;

@property (nonatomic , strong)AddressModel *model;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *phoneLabel;

@property (nonatomic , strong)UILabel *addressLabel;

@property (nonatomic , strong)UIButton *defaultButton;

@property (nonatomic , strong)UIButton *modifyButton;

@property (nonatomic , strong)UIButton *deleteButton;

@end
