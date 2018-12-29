//
//  WithdrawalPriceCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalPriceCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UITextField *priceTextField;

@property (nonatomic , strong)UILabel *TheRemainingLabel;

@end
