//
//  MessageHeadView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageHeadView.h"

@implementation MessageHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60, 15, 120, 20)];
        _timeLabel.font = HGfont(13);
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = HGColor(214, 214, 214);
        kViewRadius(_timeLabel, 3);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];

        self.backgroundColor = BackColor;
    }
    return self;
}

-(void)setModel:(MessageModel *)model
{
    _timeLabel.text = [model.updateDatetime convertDate];
}

@end
