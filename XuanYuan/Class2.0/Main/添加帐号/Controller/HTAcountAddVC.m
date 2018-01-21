//
//  HTAcountAddVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddVC.h"
#import "HTAcountAddHeaderCell.h"

@interface HTAcountAddVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) HTMainAccountsModel * saveModel;
@end

@implementation HTAcountAddVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _saveModel = [[HTMainAccountsModel alloc]init];
        _saveModel.k_id = @"niesiyang_0";
        _saveModel.accountTitle = @"帐号信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    tableView.rowHeight = UITableViewAutomaticDimension;
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddHeaderCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddHeaderCell"];
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
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HTAcountAddHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddHeaderCell" forIndexPath:@"HTAcountAddHeaderCell"];
    }
    return nil;
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
