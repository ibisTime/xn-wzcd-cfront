//
//  MessageCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 15)];
        _nameLabel.font = HGfont(14);
    }
    return _nameLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = HGfont(13);
        _contentLabel.textColor = HGColor(153, 153, 153);

    }
    return _contentLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];

    }
    return self;
}

-(void)setModel:(MessageModel *)model
{
    self.nameLabel.text = model.smsTitle;
    self.contentLabel.frame = CGRectMake(20, 50, SCREEN_WIDTH - 40, 0);
    self.contentLabel.text = model.smsContent;
    [_contentLabel sizeToFit];
}

@end
