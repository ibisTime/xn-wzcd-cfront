//
//  ExhibitionCenterCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ExhibitionCenterCell.h"

@implementation ExhibitionCenterCell

-(UIImageView *)goodsImage
{
    if (!_goodsImage) {



        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 90 )];
//        kViewRadius(_goodsImage, 5);


        UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, 28, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:MainColor font:HGfont(10) textColor:[UIColor whiteColor]];
        label.text = @"热销";
        [_goodsImage addSubview:label];

    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, SCREEN_WIDTH - 150, 0)];
        _nameLabel.font = HGfont(15);
        _nameLabel.numberOfLines = 2;

    }
    return _nameLabel;
}

-(UILabel *)brandLabel
{
    if (!_brandLabel) {
        _brandLabel = [[UILabel alloc]init];
        _brandLabel.font = HGfont(13);
        _brandLabel.textColor = GaryTextColor;
        _brandLabel.numberOfLines = 2;

    }
    return _brandLabel;
}

-(UILabel *)allPriceLabel
{
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 80, 0, 20)];
//        _allPriceLabel.text = @"总价:20000.00元";
        _allPriceLabel.textColor = PriceColor;
        _allPriceLabel.font = HGfont(15);

    }
    return _allPriceLabel;
}

-(UILabel *)downPaymentLabel
{
    if (!_downPaymentLabel) {
        _downPaymentLabel = [[UILabel alloc]init];
//        _downPaymentLabel.text = @"首付:40000.00";
        _downPaymentLabel.font = HGfont(13);
        _downPaymentLabel.textColor = GaryTextColor;
    }
    return _downPaymentLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.allPriceLabel];
        [self addSubview:self.brandLabel];
        [self addSubview:self.downPaymentLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModel:(ExhibitionCenterModel *)Model
{
    _nameLabel.text = Model.name;
    [_nameLabel sizeToFit];
    _brandLabel.text = Model.seriesName;
    _brandLabel.frame = CGRectMake(140, 15+_nameLabel.frame.size.height, SCREEN_WIDTH - 150, 0);
    [_brandLabel sizeToFit];
    _allPriceLabel.text = [NSString stringWithFormat:@"总价:%.2f",[Model.salePrice floatValue]/1000];
    [_allPriceLabel sizeToFit];
    _downPaymentLabel.text = [NSString stringWithFormat:@"首付:%.2f",[Model.sfAmount floatValue]/1000];
    _downPaymentLabel.frame = CGRectMake(150 + _allPriceLabel.frame.size.width, 80, SCREEN_WIDTH - 160 - _allPriceLabel.frame.size.width, 20);
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[Model.pic convertImageUrl]]];
}

@end
