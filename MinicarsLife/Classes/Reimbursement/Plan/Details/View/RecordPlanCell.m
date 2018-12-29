//
//  RecordPlanCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordPlanCell.h"

@implementation RecordPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 45, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];
        nameLabel.text = @"还款计划";
        [self addSubview:nameLabel];

        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 50/2 - 5.5, 6, 11)];
        youImage.image = HGImage(@"more");
        [self addSubview:youImage];


    }
    return self;
}

@end
