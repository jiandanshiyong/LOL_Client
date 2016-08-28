//
//  NewsViewController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsListViewController.h"

#import "SCNavTabBarController.h"
#import "CONSTS.h"
#import "EnumConstans.h"
#import "RDVTabBarController.h"


@interface NewsViewController ()

@end

@implementation NewsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 隐藏新闻界面－导航条
    self.navigationController.navigationBarHidden =YES;
    // 显示tabbar
    self.rdv_tabBarController.tabBarHidden= NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_RGB(55, 63, 80, 1);
    
    NSArray *titleArr = @[@"最新", @"活动", @"赛事", @"视频", @"娱乐", @"官方", @"美女", @"攻略",];

    NSMutableArray *listArr = [[NSMutableArray alloc] init];
    //8个列表页面
    for (NSInteger i = 0; i < 8; i++) {
        NewsListViewController *listVC = [[NewsListViewController alloc] init];
        listVC.title = titleArr[i];
        
        //指定页面类型  区分子页面
        listVC.type = i;
    
        [listArr addObject:listVC];
    }
    
    //创建SCNavTabBarController 新闻 顶部跨屏幕多导航
    SCNavTabBarController *scNavTBC = [[SCNavTabBarController alloc] init];
    scNavTBC.subViewControllers = listArr;
    scNavTBC.navTabBarColor = UICOLOR_RGB(33, 43, 60, 0.5);      //背景色;
    [scNavTBC addParentController:self];

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
