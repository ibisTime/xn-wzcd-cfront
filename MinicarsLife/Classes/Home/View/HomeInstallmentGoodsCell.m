//
//  HomeInstallmentGoodsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeInstallmentGoodsCell.h"
#define x 16
#define y 15
#define w 120
#define h 90

@implementation HomeInstallmentGoodsCell

-(UIImageView *)goodsImage
{
    if (!_goodsImage) {

        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];

    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(10 + x + w, y + 10, SCREEN_WIDTH -  160, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(16) textColor:[UIColor blackColor]];

    }
    return _nameLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithFrame:CGRectMake(10 + x + w, 79, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(15) textColor:PriceColor];

    }
    return _priceLabel;
}

-(UILabel *)MonthlyPriceLabel
{
    if (!_MonthlyPriceLabel) {
        _MonthlyPriceLabel = [UILabel labelWithFrame:CGRectMake(20 + x + w + _priceLabel.frame.size.width, 81, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(13) textColor:GaryTextColor];

    }
    return _MonthlyPriceLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.MonthlyPriceLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModel:(HomeModel *)Model
{

    NSArray *array = Model.productSpecsList;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Model.pic convertImageUrl]]]];
    NSLog(@"%@",Model.monthAmount);
    _nameLabel.text = Model.name;
    [_nameLabel sizeToFit];
    if ([Model.price floatValue]/1000 >= 10000) {
        _priceLabel.text = [NSString stringWithFormat:@"%.2f万",[Model.price floatValue] / 1000/10000];
        [_priceLabel sizeToFit];
    }else
    {
        _priceLabel.text = [NSString stringWithFormat:@"%.2f",[Model.price floatValue] / 1000];
        [_priceLabel sizeToFit];
    }

    _MonthlyPriceLabel.text = [NSString stringWithFormat:@"月供:%.2f",[array[0][@"monthAmount"] floatValue] / 1000];
    _MonthlyPriceLabel.frame = CGRectMake(20 + x + w + _priceLabel.frame.size.width, 81, 0, 20);
    [_MonthlyPriceLabel sizeToFit];
}

@end
