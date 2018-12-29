//
//  BaseViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


-(UIButton *)LeftBackbButton
{
    if (!_LeftBackbButton) {
        _LeftBackbButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _LeftBackbButton.frame = CGRectMake(0, 0, 44, 44);
        [_LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    }
    return _LeftBackbButton;
}

-(UIButton *)RightButton
{
    if (!_RightButton) {
        _RightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _RightButton.frame = CGRectMake(0, 0, 44, 44);
        _RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _RightButton.titleLabel.font = HGfont(16);
    }
    return _RightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor  =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = item;




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
