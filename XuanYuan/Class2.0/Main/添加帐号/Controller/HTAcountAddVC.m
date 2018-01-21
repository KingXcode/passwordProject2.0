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

@interface HTAcountAddVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) HTMainAccountsModel * saveModel;

@property (nonatomic,strong) NSMutableArray * sectionArray;

@end

@implementation HTAcountAddVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)loadData
{
    _saveModel = [[HTMainAccountsModel alloc]initWithValue:@{@"k_id":@"niesiyang_0",@"creatTime":@([[NSDate date]timeIntervalSince1970]).stringValue}];

    _sectionArray = [NSMutableArray array];
    [_sectionArray addObject:@[@"登录信息"]];
    [_sectionArray addObject:@[@"账号",
                               @"密码"]];

}

-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBackgroundColor);
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddHeaderCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddHeaderCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.sectionArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.sectionArray[indexPath.section][indexPath.row];
    __weak typeof(self) __self = self;
    if ([title isEqualToString:@"登录信息"]) {
        HTAcountAddHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddHeaderCell" forIndexPath:indexPath];
        cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",@(self.saveModel.iconType)]];
        [cell configText:self.saveModel.accountTitle];
        [cell setTextChange:^(NSString *text) {
            __self.saveModel.accountTitle = text;
        }];
        return cell;
    }
    
    if ([title isEqualToString:@"帐号"]) {
        HTAcountAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddCell" forIndexPath:indexPath];
        [cell configText:self.saveModel.account];
        [cell setTextChange:^(NSString *text) {
            __self.saveModel.account = text;
        }];
        return cell;
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.sectionArray[indexPath.section][indexPath.row];

    if ([title isEqualToString:@"登录信息"]) {
        return 80;
    }
    if ([title isEqualToString:@"帐号"]) {
        return 63;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 10;
    }
    return 0.1;
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
