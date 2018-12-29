//
//  MyHeadView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyHeadDelegate <NSObject>

-(void)MyHeadButton:(NSInteger)tag;

@end

@interface MyHeadView : UIView

@property (nonatomic, assign) id <MyHeadDelegate> delegate;

@property (nonatomic , strong)UIImageView *backImage;

@property (nonatomic , strong)UIImageView *headImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *phoneLabel;

@property (nonatomic , strong)UIButton *balanceButton;

@property (nonatomic , strong)UIButton *integralButton;


@end
