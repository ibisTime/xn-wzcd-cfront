//
//  WithdrawalPriceCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "WithdrawalPriceCell.h"
#import "WLDecimalKeyboard.h"
@implementation WithdrawalPriceCell

{
    BOOL isHaveDian;

    WLDecimalKeyboard *inputView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 20, 20)];
        _nameLabel.text = @"提现金额";
        _nameLabel.font = HGfont(13);
        _nameLabel.textColor = HGColor(122, 122, 122);
    }
    return _nameLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 54, 26, 26)];
        _priceLabel.text = @"¥";
        _priceLabel.font = HGfont(26);
    }
    return _priceLabel;
}

-(UITextField *)priceTextField
{
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(45, 60 , SCREEN_WIDTH - 45, 20)];
        _priceTextField.font = HGfont(20);
        _priceTextField.delegate = self;
        [_priceTextField setValue:[UIFont systemFontOfSize:18.0] forKeyPath:@"_placeholderLabel.font"];
        inputView = [[WLDecimalKeyboard alloc] init];
        _priceTextField.inputView = inputView;
    }
    return _priceTextField;
}

-(UILabel *)TheRemainingLabel
{
    if (!_TheRemainingLabel) {
        _TheRemainingLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 30, 20)];
        _TheRemainingLabel.textColor = HGColor(122, 122, 122);
        _TheRemainingLabel.font = HGfont(13);
        _TheRemainingLabel.text = @"可用余额0.00元";
    }
    return _TheRemainingLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.priceTextField];
        [self addSubview:self.TheRemainingLabel];

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH - 20, 1)];
        view.backgroundColor = HGColor(245, 245, 245);
        [self addSubview:view];

    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {

        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确

            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    //                    [self showError:@"亲，第一个数字不能为小数点"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') {
                    //                    [self showError:@"亲，第一个数字不能为0"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }

            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;

                }else{
                    //                    [self showError:@"亲，您已经输入过小数点了"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点

                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        //                        [self showError:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            //            [self showError:@"亲，您输入的格式不正确"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }

}



@end
