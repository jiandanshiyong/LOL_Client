
//
//  BaseTabBarController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "RootTabBarController.h"

#import "BaseNavigationController.h"
#import "BaseViewController.h"

#import "CONSTS.h"
#import "RDVTabBarItem.h"

@interface RootTabBarController (){
    NSArray * titleArr;
}

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArr = @[@"新闻", @"英雄", @"资料", @"设置"];

    [self addViewControllers];
}

- (void)addViewControllers{
    
    NSArray *classNameArr = @[@"NewsViewController",
                              @"HerosViewController",
                              @"InfosViewController",
                              @"SettingsViewController"];
    //创建各个页面
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    NSInteger index =0;
    for (NSString *className in classNameArr) {
        
        BaseViewController *vc = [[NSClassFromString(className) alloc] init];
        vc.title = titleArr[index];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [viewControllers addObject:nav];
        
        index ++;
    }
    
    self.viewControllers = viewControllers;
    
    [self configTabbar];
}

//配置tabbar上的内容
- (void)configTabbar{
    
    //文字属性修改
    NSDictionary * selectedTitleAttributesDic = @{NSFontAttributeName : [UIFont systemFontOfSize:9.0f], NSForegroundColorAttributeName : UICOLOR_RGB(68, 135, 194, 1)};
    NSDictionary * unselectedTitleAttributesDic = @{NSFontAttributeName : [UIFont systemFontOfSize:9.0f], NSForegroundColorAttributeName : UICOLOR_RGB(181, 186, 195, 1)};
    
    NSInteger index = 0;
    for(RDVTabBarItem *item in self.tabBar.items){
        
        //设置title
        item.title = titleArr[index];
        item.selectedTitleAttributes = selectedTitleAttributesDic;
        item.unselectedTitleAttributes =unselectedTitleAttributesDic;
        
        
        // 图片
        NSArray * imageArr = @[@"tab_icon_news",
                               @"tab_icon_friend",
                               @"tab_icon_quiz",
                               @"tab_icon_more"];
        //设置图片
        UIImage * selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press.png", imageArr[index]]];
        UIImage * unselectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal.png", imageArr[index]]];
        [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:unselectImage];
        
        index ++;
    }
    
    
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
