//
//  SelectModelsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SelectModelsVC.h"
#import "SelectModelsTableView.h"
#import "ExhibitionCenterModel.h"
@interface SelectModelsVC ()<RefreshDelegate>
 @property (nonatomic , strong)SelectModelsTableView *tableView;

@property (nonatomic, strong) NSMutableArray <ExhibitionCenterModel *>*model;
@end

@implementation SelectModelsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    [self initTableView];
    [self LoadData];
}

-(void)LoadData
{
    if ([self.titleStr isEqualToString:@"品牌"]) {
        [self PPloadData];
    }
    if ([self.titleStr isEqualToString:@"车系"]) {
        [self CHEXIloadData];
    }
    if ([self.titleStr isEqualToString:@"车型"]) {
        [self CHEXINGloadData];
    }
}

//品牌
-(void)PPloadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = PPURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"status"] = @"1";
    helper.tableView = self.tableView;
    [helper modelClass:[ExhibitionCenterModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);

            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

        }];
    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"status"] = @"1";
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView beginRefreshing];
}

//车系
-(void)CHEXIloadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = CXURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"brandCode"] = weakSelf.brandCode;
    [helper modelClass:[ExhibitionCenterModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);

            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

        }];
    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"status"] = @"1";
        helper.parameters[@"brandCode"] = weakSelf.brandCode;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView beginRefreshing];
}

-(void)CHEXINGloadData{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = CXGLURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"brandCode"] = weakSelf.brandCode;
    [helper modelClass:[ExhibitionCenterModel class]];

    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);

            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

        }];
    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"status"] = @"1";
        helper.parameters[@"brandCode"] = weakSelf.brandCode;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <ExhibitionCenterModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                ExhibitionCenterModel *model = (ExhibitionCenterModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView beginRefreshing];
}

- (void)refreshTableView:(TLTableView*)refreshTableview didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([self.titleStr isEqualToString:@"品牌"]) {
        // 创建通知
        ExhibitionCenterModel *model = self.model[indexPath.row];
        NSDictionary *dic = @{@"brandCode":model.code,@"name":model.name};
        WGLog(@"%@",dic);
        NSNotification *notification =[NSNotification notificationWithName:PPLoadDataNotice object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([self.titleStr isEqualToString:@"车系"]) {
        SelectModelsVC *vc = [[SelectModelsVC alloc]init];
        vc.titleStr = @"车型";
        ExhibitionCenterModel *model = self.model[indexPath.row];
        vc.brandCode = model.brandCode;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.titleStr isEqualToString:@"车型"]) {
        ExhibitionCenterModel *model = self.model[indexPath.row];
        NSDictionary *dic = @{@"brandCode":model.brandCode,@"name":model.name,@"model":model};
        NSNotification *notification =[NSNotification notificationWithName:CXLoadDataNotice object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }

}

#pragma mark - Init
- (void)initTableView {

    self.tableView = [[SelectModelsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];

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
