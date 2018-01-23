//
//  HTKindAddVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTKindAddVC.h"
#import "HTToolSet.h"
#import "HTAcountAddVC.h"

@interface HTKindAddVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<HTMainAccountsKindItem *> * dataArray;
@end

@implementation HTKindAddVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

-(void)loadData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"kindList" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        HTMainAccountsKindItem *item = [HTMainAccountsKindItem mj_objectWithKeyValues:dict];
        [dataArray addObject:item];
    }
    _dataArray = dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择分类";
    [self creatUI];

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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
        [cell ht_bottomLineShow];
    }
    HTMainAccountsKindItem *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.kindName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HTMainAccountsKindItem *model = self.dataArray[indexPath.row];
    if ([model.k_id isEqualToString:@"niesiyang_0"])
    {//帐号信息
        HTAcountAddVC *vc = [[HTAcountAddVC alloc]initWithKindModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([model.k_id isEqualToString:@"niesiyang_1"])
    {//备忘录
    
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
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
