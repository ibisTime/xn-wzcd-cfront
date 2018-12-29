//
//  CarLoanCalculatorHeadCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarLoanCalculatorHeadCell.h"

@implementation CarLoanCalculatorHeadCell

-(UILabel *)allPriceLabel
{
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40, 30)];
        _allPriceLabel.textColor = [UIColor whiteColor];
        _allPriceLabel.font = HGfont(26);
        _allPriceLabel.text = @"0.00";
    }
    return _allPriceLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MainColor;
        UILabel *zongLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 20)];
        zongLabel.textColor = [UIColor whiteColor];
        zongLabel.font = HGfont(14);
        zongLabel.text = @"总价(元)";
        [self addSubview:zongLabel];

        [self addSubview:self.allPriceLabel];


        NSArray *array = @[@"首付(元)",@"月供(元)",@"多花(元)",@"0.00",@"0.00",@"0.00"];
        for (int i = 0; i < 6; i ++) {
            _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(i%3*SCREEN_WIDTH/3, 100 + i/3*30, SCREEN_WIDTH/3, 25)];
            _priceLabel.textColor = [UIColor whiteColor];
            _priceLabel.textAlignment = NSTextAlignmentCenter;

            _priceLabel.text = array[i];
            _priceLabel.tag = 997 + i;
            if (i>2) {
                _priceLabel.font = HGfont(14);
            }else{
                _priceLabel.font = HGfont(16);
            }
            [self addSubview:_priceLabel];
        }
        for (int i = 0; i < 2; i ++) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3 + i %2 * SCREEN_WIDTH/3, 100 + 15, 0.5, 30)];
            lineView.backgroundColor = [UIColor whiteColor];
            [self addSubview:lineView];
        }


    }
    return self;
}

-(void)setCarModel:(ExhibitionCenterModel *)carModel
{
    _allPriceLabel.text = [NSString stringWithFormat:@"¥%.2f ",[carModel.salePrice floatValue]/1000];
}

@end

