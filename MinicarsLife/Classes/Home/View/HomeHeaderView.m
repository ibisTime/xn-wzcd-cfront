//
//  HomeHeaderView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIButton *)headerButton
{
    if (!_headerButton) {
        _headerButton = [UIButton buttonWithTitle:@"推荐车型" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] titleFont:14 cornerRadius:0];
        _headerButton.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 35);
        _headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _headerButton;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headerButton];

        _calculateButton = [UIButton buttonWithTitle:@"车贷计算器" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] titleFont:14 cornerRadius:0];
        _calculateButton.frame = CGRectMake(SCREEN_WIDTH - 110, 0, 100, 35);
        _calculateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_calculateButton];

        _youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20, 13, 6, 11)];
        _youImage.image = HGImage(@"more");
        [self addSubview:_youImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

    }
    return self;
}


@end
