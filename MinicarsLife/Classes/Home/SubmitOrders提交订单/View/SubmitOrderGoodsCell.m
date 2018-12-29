//
//  SubmitOrderGoodsCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SubmitOrderGoodsCell.h"

@implementation SubmitOrderGoodsCell

-(UIImageView *)goodsImage
{
    if(!_goodsImage)
    {
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 90, 90)];
    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(115, 10, SCREEN_WIDTH - 130, 0)  textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(16) textColor:[UIColor blackColor]];
//        _nameLabel.text = @"哈士大夫撒旦撒打飞机撒打发回家撒地方看哈士大夫撒旦撒打飞机撒打发回家撒地方看哈士大夫撒旦撒打飞机撒打发回家撒地方看";
        _nameLabel.numberOfLines = 2;


    }
    return _nameLabel;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel)
    {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(117, 10 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
//        _introduceLabel.text = @"沃尔沃 2014款 黑色";

    }
    return _introduceLabel;
}

-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [UILabel labelWithFrame:CGRectMake(117, 80, SCREEN_WIDTH - 117 - 65, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:HGColor(252, 113, 42)];
    }
    return _priceLabel;

}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 65, 80, 50, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:HGColor(252, 113, 42)];
        _numberLabel.text = @"x1";
    }
    return _numberLabel;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.introduceLabel];

        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];
    }
    return self;
}

-(void)setModel:(HomeModel *)model
{
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.pic convertImageUrl]]]];
    _nameLabel.text = model.name;
    _nameLabel.frame = CGRectMake(115, 10, SCREEN_WIDTH - 130, 0);
    [_nameLabel sizeToFit];
    _introduceLabel.frame = CGRectMake(117, 10 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15);

    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.pic convertImageUrl]]]];
    _nameLabel.text = model.name;


}

-(void)setDic:(NSDictionary *)dic
{

    _priceLabel.text = [NSString stringWithFormat:@"¥:%.2f",[dic[@"price"] floatValue]/1000];
    _nameLabel.frame = CGRectMake(115, 10, SCREEN_WIDTH - 130, 0);
    [_nameLabel sizeToFit];
    _introduceLabel.frame = CGRectMake(117, 10 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15);
    _introduceLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];

}


@end
