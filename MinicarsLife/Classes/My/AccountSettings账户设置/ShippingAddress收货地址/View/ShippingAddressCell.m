//
//  ShippingAddressCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ShippingAddressCell.h"

@implementation ShippingAddressCell
{
    CGFloat y;
    CGFloat h;
    UIView *lineView;
    UIView *lineView1;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH/2 - 15, 20)];
        _nameLabel.font = HGfont(15);
        _nameLabel.text = @"王明";
        _nameLabel.textColor = TextColor;
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, SCREEN_WIDTH/2 - 15, 20)];
        _phoneLabel.font = HGfont(14);
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.text = @"13506537519";
        _phoneLabel.textColor = TextColor;
    }
    return _phoneLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH - 30, 0)];
        _addressLabel.textColor = TextColor;
        _addressLabel.font = HGfont(13);
        _addressLabel.numberOfLines = 0;

    }
    return _addressLabel;
}

-(UIButton *)defaultButton
{
    if (!_defaultButton) {
        _defaultButton = [UIButton buttonWithType:(UIButtonTypeCustom)];

        [_defaultButton setTitle:@"默认地址" forState:(UIControlStateNormal)];
        [_defaultButton setTitleColor:TextColor forState:(UIControlStateNormal)];
        [_defaultButton setTitleColor:ButtonTextColor forState:(UIControlStateSelected)];
        _defaultButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _defaultButton.titleLabel.font = HGfont(13);
        [_defaultButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"tick-uncheck"] forState:(UIControlStateNormal)];
            [button setImage:[UIImage imageNamed:@"tick-Select"] forState:(UIControlStateSelected)];
        }];
        

        
    }
    return _defaultButton;
}



-(UIButton *)modifyButton
{
    if (!_modifyButton) {
        _modifyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];

        [_modifyButton setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_modifyButton setTitleColor:TextColor forState:(UIControlStateNormal)];
        _modifyButton.titleLabel.font = HGfont(13);
//        [_modifyButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
//            [button setImage:[UIImage imageNamed:@"tick-uncheck"] forState:(UIControlStateNormal)];
//        }];
    }
    return _modifyButton;
}

-(UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];

        [_deleteButton setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteButton setTitleColor:TextColor forState:(UIControlStateNormal)];
        _deleteButton.titleLabel.font = HGfont(13);
//        [_deleteButton SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
//            [button setImage:[UIImage imageNamed:@"tick-uncheck"] forState:(UIControlStateNormal)];
//        }];
    }
    return _deleteButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.addressLabel];

        [self addSubview:self.defaultButton];
        [self addSubview:self.modifyButton];
        [self addSubview:self.deleteButton];

        lineView = [[UIView alloc]init];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];


        lineView1 = [[UIView alloc]init];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

    }
    return self;
}

-(void)setModel:(AddressModel *)model
{
    _nameLabel.text = model.addressee;
    _phoneLabel.text = model.mobile;
    _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",model.province,model.city,model.area,model.detail];
    [_addressLabel sizeToFit];
    y = _addressLabel.frame.origin.y;
    h = _addressLabel.frame.size.height;
    lineView.frame = CGRectMake(15, h + y + 20, SCREEN_WIDTH - 30, 1);
    lineView1.frame = CGRectMake(0, 110 + h, SCREEN_WIDTH , 10);
    _defaultButton.frame = CGRectMake(15, h + 75, 100, 35);
    _modifyButton.frame = CGRectMake(SCREEN_WIDTH - 150, h + 75, 70, 35);
    _deleteButton.frame = CGRectMake(SCREEN_WIDTH - 80, h + 75, 70, 35);

    if ([model.isDefault isEqualToString:@"1"]) {
        _defaultButton.selected = YES;
    }else
    {
        _defaultButton.selected = NO;
    }

}

@end
