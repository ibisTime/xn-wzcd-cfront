//
//  PayWayCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayWayCellDelegate <NSObject>

-(void)PayWayCellButton:(NSInteger)tag;

@end


@interface PayWayCell : UITableViewCell

@property (nonatomic, assign) id <PayWayCellDelegate> delegate;

@property (nonatomic , strong)UIImageView *payImg;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIImageView *roundImage;



@end
