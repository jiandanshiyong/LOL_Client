//
//  BaseNavigationController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "BaseNavigationController.h"
#import "CONSTS.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.增加导航条的背景
    [self.navigationBar setBarTintColor:UICOLOR_RGB(33, 39, 53, 1)];
    
    // 2. navbar上文字属性修改
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:24.0f], NSForegroundColorAttributeName : [UIColor whiteColor]}];
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
