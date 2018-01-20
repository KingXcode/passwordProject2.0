//
//  XYTabBarController.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYTabBarController.h"

@interface XYTabBarController ()

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(TabBarTint);
    
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
