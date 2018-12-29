//
//  IntroductionCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "IntroductionCell.h"

@implementation IntroductionCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH - 20, 0)];
        _nameLabel.font = HGfont(18);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = PriceColor;
        _priceLabel.font = HGfont(16);
        _priceLabel.numberOfLines = 0;
    }
    return _priceLabel;
}

-(UILabel *)referencePriceLabel
{
    if (!_referencePriceLabel) {
        _referencePriceLabel = [[UILabel alloc]init];
        _referencePriceLabel.textColor = GaryTextColor;
        _referencePriceLabel.font = HGfont(14);
        _referencePriceLabel.numberOfLines = 0;
    }
    return _referencePriceLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.referencePriceLabel];
    }
    return self;
}

-(void)setModel:(ExhibitionCenterModel *)model
{
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.brandName,model.name,model.seriesName];
    [_nameLabel sizeToFit];
    _priceLabel.text = [NSString stringWithFormat:@"经销商参考价:¥%.2f",[model.salePrice floatValue]/1000];
    _priceLabel.frame = CGRectMake(10, self.nameLabel.frame.size.height + 25, SCREEN_WIDTH - 20, 0);
    [_priceLabel sizeToFit];
    _referencePriceLabel.text = [NSString stringWithFormat:@"厂商指导价:¥%.2f ",[model.originalPrice floatValue]/1000];
    _referencePriceLabel.frame = CGRectMake(10, self.priceLabel.frame.origin.y + self.priceLabel.frame.size.height + 10, SCREEN_WIDTH - 20, 0);
    [_referencePriceLabel sizeToFit];
}

-(void)setHomemodel:(HomeModel *)homemodel
{
    _nameLabel.text = [NSString stringWithFormat:@"%@",homemodel.name];
    [_nameLabel sizeToFit];
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f ",[homemodel.price floatValue]/1000];
    _priceLabel.textColor = PriceColor;
    _priceLabel.frame = CGRectMake(10, self.nameLabel.frame.size.height + 25, SCREEN_WIDTH - 20, 0);
    [_priceLabel sizeToFit];
    _referencePriceLabel.text = @"";
    _referencePriceLabel.frame = CGRectMake(10, self.priceLabel.frame.origin.y + self.priceLabel.frame.size.height + 10, SCREEN_WIDTH - 20, 0);
    [_referencePriceLabel sizeToFit];
}

@end
