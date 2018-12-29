//
//  OrderDetailsGoodsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "OrderDetailsGoodsCell.h"

@implementation OrderDetailsGoodsCell

-(UIImageView *)goodsImage
{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 120, 80)];

    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(150, 20, SCREEN_WIDTH - 165, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];

    }
    return _nameLabel;
}

-(UILabel *)modelLabel
{
    if (!_modelLabel) {
        _modelLabel = [UILabel labelWithFrame:CGRectMake(150, 45, SCREEN_WIDTH - 165, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];

    }
    return _modelLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithFrame:CGRectMake(150, 70, SCREEN_WIDTH - 165, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];

    }
    return _priceLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.modelLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

-(void)setModel:(OrderModel *)model
{
    NSDictionary *dic = model.productOrderList[0];
    NSArray *imgs = [model.productOrderList[0][@"product"][@"advPic"] componentsSeparatedByString:@"||"];
    NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
    [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj convertImageUrl]) {

            [newImgs addObject:[obj convertImageUrl]];
        }
    }];
    if (newImgs.count > 0) {
        [_goodsImage sd_setImageWithURL:[NSURL URLWithString:newImgs[0]]];
    }else
    {
        [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[model.productOrderList[0][@"product"][@"advPic"] convertImageUrl]]];
    }
    _nameLabel.text = [NSString stringWithFormat:@"型号: %@",dic[@"product"][@"name"]];

    NSString *modelText = [NSString stringWithFormat:@"型号: %@",dic[@"productSpecsName"]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:modelText];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:TextColor
                    range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:PriceColor
                    range:NSMakeRange(3, modelText.length - 3)];
    _modelLabel.attributedText = attrStr;


    NSString *priceText = [NSString stringWithFormat:@"价格: ¥%.2f",[dic[@"price"] floatValue]/1000];
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:priceText];
    [attrStr1 addAttribute:NSForegroundColorAttributeName
                    value:TextColor
                    range:NSMakeRange(0, 3)];
    [attrStr1 addAttribute:NSForegroundColorAttributeName
                    value:PriceColor
                    range:NSMakeRange(3, priceText.length - 3)];
    _priceLabel.attributedText = attrStr1;


}

@end
