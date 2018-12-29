//
//  PayWayCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell
{
    UIImageView *selectImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = BackColor;
        for(int i = 0; i < 3; i++){
            NSArray *imageArray = @[@"余额",@"微信",@"支付宝"];

            UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backButton.backgroundColor = [UIColor whiteColor];
            backButton.frame = CGRectMake(0, i%3*51, SCREEN_WIDTH, 50);
            [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            backButton.tag = 100 + i;
            [self addSubview:backButton];


            _payImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
            _payImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]];
            [backButton addSubview:_payImg];

            _nameLbl = [UILabel labelWithFrame:CGRectMake(55, 0, SCREEN_WIDTH - 110, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _nameLbl.text = imageArray[i];
            [backButton addSubview:_nameLbl];

            _roundImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 10, 30, 30)];
            _roundImage.image = HGImage(@"支付未选中");
            [backButton addSubview:_roundImage];


        }

        selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 10, 30, 30)];
        selectImage.image = HGImage(@"支付选中");
        [self addSubview:selectImage];

    }
    return self;
}

-(void)backButtonClick:(UIButton *)sender
{
    selectImage.frame = CGRectMake(SCREEN_WIDTH - 45, 10 + (sender.tag - 100)%3*51, 30, 30);
    [_delegate PayWayCellButton:sender.tag];
    

}


@end
