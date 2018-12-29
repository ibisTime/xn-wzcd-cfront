//
//  AccountSettingsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccountSettingsCell.h"

@implementation AccountSettingsCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/2 - 10, 50)];
        _nameLabel.font = HGfont(15);
    }
    return _nameLabel;
}

-(UILabel *)contactLabel
{
    if (!_contactLabel) {
        _contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 30, 50)];
        _contactLabel.font = HGfont(14);
        _contactLabel.textAlignment = NSTextAlignmentRight;
        _contactLabel.textColor =kLightGreyColor;
    }
    return _contactLabel;
}

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 6, 38, 38)];
//        _headImage.image = HGImage(@"1");
    }
    return _headImage;
}

-(UIImageView *)youImage
{
    if (!_youImage) {

        _youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 19.5, 6, 11)];
        _youImage.image= HGImage(@"more");

    }
    return _youImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.headImage];
        [self addSubview:self.contactLabel];
        [self addSubview:self.youImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH - 20, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

    }
    return self;
}

@end
