//
//  HTAcountAddVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddVC.h"
#import "HTAcountAddHeaderCell.h"
#import "HTAcountAddCell.h"
#import "HTPassWordAddCell.h"
#import "HTInfoPassWordAddCell.h"

@interface HTAcountAddVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) HTMainAccountsModel * saveModel;
@end

@implementation HTAcountAddVC

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self creatUI];
}

-(void)loadData
{
    if ([HTTools ht_isBlankString:self.a_id]) {
        [self defaultData];
        return;
    }
    NSString *pred = [NSString stringWithFormat:@"a_id = %@",self.a_id];
    RLMResults<HTMainAccountsModel *> *modelList = [HTMainAccountsModel objectsWhere:pred];
    if (modelList.count<=0) {
        [self defaultData];
    }
    else
    {
        _saveModel = modelList.firstObject;
    }
}

-(void)defaultData
{
    double creatTime = [[NSDate date]timeIntervalSince1970];
    _saveModel = [[HTMainAccountsModel alloc]initWithValue:@{@"k_id":@"niesiyang_0",
                                                             @"a_id":@(creatTime).stringValue,
                                                             @"creatTime":@(creatTime).stringValue}];
}


-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBackgroundColor);
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddHeaderCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddHeaderCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTPassWordAddCell" bundle:nil] forCellReuseIdentifier:@"HTPassWordAddCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTInfoPassWordAddCell" bundle:nil] forCellReuseIdentifier:@"HTInfoPassWordAddCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma -mark- tableView delegate  datasuoce

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) __self = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (indexPath.section == 2) {
            [__self.saveModel.infoPassWord removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
    }];
    return @[deleteAction];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return self.saveModel.infoPassWord.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) __self = self;

    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            HTAcountAddHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddHeaderCell" forIndexPath:indexPath];
            cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",@(self.saveModel.iconType)]];
            [cell configText:self.saveModel.accountTitle];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.accountTitle = text;
            }];
            return cell;
        }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            HTAcountAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddCell" forIndexPath:indexPath];
            [cell configText:self.saveModel.account];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.account = text;
            }];
            return cell;
        }
        
        if (indexPath.row == 1) {
            HTPassWordAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTPassWordAddCell"];
            [cell configText:self.saveModel.password];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.password = text;
            }];
            return cell;
        }
    }
    
    if (indexPath.section == 2) {
        __weak HTMainAccountsSubModel *info = [self.saveModel.infoPassWord objectAtIndex:indexPath.row];
        HTInfoPassWordAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTInfoPassWordAddCell"];
        [cell configSubTitle:info.subTitle andPassword:info.password];
        [cell setTextChange:^(NSString *subTitle, NSString *password) {
            info.subTitle = subTitle;
            info.password = password;
        }];
        return cell;
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 63;
        }
        
        if (indexPath.row == 1) {
            return 101;
        }
    }
    if (indexPath.section == 2) {
        return 68;
    }    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 10;
    }
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 44;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.dk_backgroundColorPicker = DKColorPickerWithKey(viewBackgroundColor);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:@"点击添加次要密码" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(addinfoPassWord) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}

-(void)addinfoPassWord
{
    HTMainAccountsSubModel *sub = [[HTMainAccountsSubModel alloc]init];
    [self.saveModel.infoPassWord addObject:sub];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
