//
//  SubmitOrderBankCardCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"
@interface SubmitOrderBankCardCell : UITableViewCell

@property (nonatomic , strong)BankCardModel *model;

@property (nonatomic , strong)UILabel *backLabel;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *cardholderLbl;

@property (nonatomic , strong)UILabel *accountNameLbl;

@property (nonatomic , strong)UILabel *cardNumberLbl;

@end
