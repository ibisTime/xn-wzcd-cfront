//
//  MYCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MYCell.h"

@implementation MYCell

-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage  = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17.5, 15, 15)];

    }
    return _iconImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(14) textColor:[UIColor blackColor]];

    }
    return _nameLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];

        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 19.5, 6, 11)];
        youImage.image= HGImage(@"more");
        [self addSubview:youImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH - 20, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

    }
    return self;

}

@end
