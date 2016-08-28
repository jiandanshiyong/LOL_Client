//
//  HerosViewController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "HerosViewController.h"
#import "CONSTS.h"
#import "HerosListViewController.h"

@interface HerosViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UISegmentedControl *_sgControl;
}

@end

@implementation HerosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO; //禁止滑动视图上下滑动
    
    [self initNavBar];
    [self initUI];
}


#pragma mark - 初始化
- (void)initNavBar{
    _sgControl =[[UISegmentedControl alloc] initWithItems:@[@"本周限免", @"全部英雄"]];
    _sgControl.selectedSegmentIndex = 0;
    [_sgControl addTarget:self action:@selector(segmentedControAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _sgControl;
}

-(void)initUI{
    //左右的滑动视图
    _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT-49)];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate =self;
    [self.view addSubview:_scrollView];
    
    //两个列表页面
    for (NSInteger i = 0; i <2; i++) {
        HerosListViewController *heroList = [[HerosListViewController alloc] init];
        heroList.type = i; //增加 页面标签以区分
        [self addChildViewController:heroList];
        
        heroList.view.frame = CGRectMake(i*SWIDTH, 0, SWIDTH, SHEIGHT-49);
        
        [_scrollView addSubview:heroList.view];
    }
    
    _scrollView .contentSize= CGSizeMake(2*SWIDTH, SHEIGHT-49);
}


#pragma mark - action
- (void)segmentedControAction:(UISegmentedControl *)sg{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(sg.selectedSegmentIndex*SWIDTH, 0);
    }];
}

#pragma mark - UIScrollViewDelegate
//滑动减速停止时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = _scrollView.contentOffset.x/SWIDTH;
    _sgControl.selectedSegmentIndex = page;
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
