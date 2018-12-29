//
//  CarLoanApplicationCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanApplicationCell.h"

@implementation CarLoanApplicationCell


-(UILabel *)SerialNumberLabel
{
    if(!_SerialNumberLabel)
    {
        _SerialNumberLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 100, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:HGColor(102, 102, 102)];
    }
    return _SerialNumberLabel;
}

-(UILabel *)stateLabel
{
    if(!_stateLabel){
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 90, 0, 75, 30) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:MainColor];
    }
    return _stateLabel;
}

-(UIImageView *)carImage
{
    if(!_carImage)
    {
        _carImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 110, 80)];
        _carImage.image = HGImage(@"1");
    }
    return _carImage;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(135, 40, SCREEN_WIDTH - 150, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:HGColor(102, 102, 102)];

    }
    return _nameLabel;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel)
    {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(135, 70, SCREEN_WIDTH - 150, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:HGColor(102, 102, 102)];

    }
    return _introduceLabel;
}

-(UILabel *)downPayLabel
{
    if(!_downPayLabel)
    {
        _downPayLabel = [UILabel labelWithFrame:CGRectMake(135, 100, SCREEN_WIDTH - 150, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:HGColor(102, 102, 102)];
        _downPayLabel.text = @"";
    }
    return _downPayLabel;

}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];

        [self addSubview:self.SerialNumberLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.carImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.introduceLabel];
        [self addSubview:self.downPayLabel];

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 10)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];
    }
    return self;
}

-(void)setModel:(CarLoansModel *)model
{

    _SerialNumberLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.code];
    if ([model.status isEqualToString:@"0"]) {
        _stateLabel.text = @"待处理";
    }else
    {
        _stateLabel.text = @"已通过";
    }
    _nameLabel.text = model.seriesName;
    NSDictionary *dic = model.car;
    [_carImage sd_setImageWithURL:[NSURL URLWithString:[dic[@"pic"] convertImageUrl]]];
    _introduceLabel.text = [NSString stringWithFormat:@"总价:¥%.2f",[dic[@"salePrice"] floatValue]/1000];
    _downPayLabel.text = [NSString stringWithFormat:@"首付:¥%.2f",model.sfAmount/1000];

//    _priceLabel.frame = CGRectMake(self.downPayLabel.frame.size.width + 151, 100, SCREEN_WIDTH - (self.downPayLabel.frame.size.width + 166), 20);

}

@end
