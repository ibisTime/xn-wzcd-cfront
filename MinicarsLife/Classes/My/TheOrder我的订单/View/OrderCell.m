//
//  OrderCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell
{
    UIView *lineView2;
}
-(UILabel *)SerialNumberLabel
{
    if(!_SerialNumberLabel)
    {
        _SerialNumberLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 100, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(11) textColor:HGColor(102, 102, 102)];

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

-(UIImageView *)goodsImage
{
    if(!_goodsImage)
    {
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 90, 90)];
        _goodsImage.image = HGImage(@"1");
    }
    return _goodsImage;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(115, 40, SCREEN_WIDTH - 130, 0) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(16) textColor:[UIColor blackColor]];
        _nameLabel.numberOfLines = 2;

    }
    return _nameLabel;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel)
    {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(117, 40 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];

    }
    return _introduceLabel;
}

-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [UILabel labelWithFrame:CGRectMake(117, 110, SCREEN_WIDTH - 117 - 65, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:HGColor(252, 113, 42)];
    }
    return _priceLabel;

}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 65, 110, 50, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:TextColor];
        _numberLabel.text = @"x1";
    }
    return _numberLabel;

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
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.introduceLabel];

        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];


        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

        MinicarsLifeWeakSelf;
        _cancelButton = [UIButton buttonWithTitle:@"取消订单" titleColor:GaryTextColor backgroundColor:kClearColor titleFont:14];
        _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 230, 150, 100, 40);
        kViewBorderRadius(weakSelf.cancelButton, 5, 0.5, GaryTextColor);
        [self addSubview:_cancelButton];

        _ContinueButton  = [UIButton buttonWithTitle:@"继续支付" titleColor:MainColor backgroundColor:kClearColor titleFont:14];
        _ContinueButton.frame = CGRectMake(SCREEN_WIDTH - 230 + 115, 150, 100, 40);
        kViewBorderRadius(weakSelf.ContinueButton, 5, 0.5, MainColor);
        [self addSubview:_ContinueButton];



        lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 10)];
        lineView2.backgroundColor = LineBackColor;
        [self addSubview:lineView2];
    }
    return self;
}


-(void)setModel:(OrderModel *)model
{

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

    _SerialNumberLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.code];
    if ([model.status isEqualToString:@"1"]) {
        _cancelButton.hidden = NO;
        _ContinueButton.hidden = NO;
        lineView2.frame = CGRectMake(0, 200, SCREEN_WIDTH, 10);
        _stateLabel.text = @"待支付";
        [_ContinueButton setTitle:@"继续支付" forState:(UIControlStateNormal)];
    }else if ([model.status isEqualToString:@"2"])
    {
        _cancelButton.hidden = YES;
        _ContinueButton.hidden = YES;
        lineView2.frame = CGRectMake(0, 140, SCREEN_WIDTH, 10);
        _stateLabel.text = @"待发货";
    }else if ([model.status isEqualToString:@"3"])
    {
        _cancelButton.hidden = YES;
        _ContinueButton.hidden = NO;
        [_ContinueButton setTitle:@"确认收货" forState:(UIControlStateNormal)];
        lineView2.frame = CGRectMake(0, 200, SCREEN_WIDTH, 10);
        _stateLabel.text = @"已发货";
    }else if ([model.status isEqualToString:@"4"])
    {
        _cancelButton.hidden = YES;
        _ContinueButton.hidden = YES;
        lineView2.frame = CGRectMake(0, 140, SCREEN_WIDTH, 10);
        _stateLabel.text = @"已收货";
    }else
    {
        _cancelButton.hidden = YES;
        _ContinueButton.hidden = YES;
        lineView2.frame = CGRectMake(0, 140, SCREEN_WIDTH, 10);
        _stateLabel.text = @"已取消";
    }
    NSLog(@"%@",_model.receiver);
    _nameLabel.text = model.productOrderList[0][@"product"][@"name"];
    _nameLabel.frame = CGRectMake(115, 40, SCREEN_WIDTH - 130, 0);
    [_nameLabel sizeToFit];
    _introduceLabel.frame = CGRectMake(117, 40 + _nameLabel.frame.size.height + 5, SCREEN_WIDTH - 152, 15);
    _introduceLabel.text = model.productOrderList[0][@"productSpecsName"];
    _priceLabel.text = [NSString stringWithFormat:@"¥:%.2f",[model.productOrderList[0][@"price"] floatValue]/1000];

}


@end
