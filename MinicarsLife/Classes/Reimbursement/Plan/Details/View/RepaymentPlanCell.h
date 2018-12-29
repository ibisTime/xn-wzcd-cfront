//
//  RepaymentPlanCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepaymentPlanCell : UITableViewCell

@property (nonatomic , strong)NSDictionary *dic;

@property (nonatomic , strong)UILabel *numberLbl;

@property (nonatomic , strong)UILabel *priceLbl;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UIView *progressBarView;

@end
