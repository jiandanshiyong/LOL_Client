//
//  NewsDetailViewController.m
//  LOL001
//
//  Created by 张凯 on 16/7/7.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "RDVTabBarController.h"
#import "SVProgressHUD.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NewsDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //显示导航条
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title= @"新闻详情";
    
    //隐藏tabbar
    self.rdv_tabBarController.tabBarHidden= YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlStr =  [NSString stringWithFormat:kNewsDetailUrlString,_newsId];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //应用程序网络活动指示器
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //Hud
    [SVProgressHUD showWithStatus:@"loading..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
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
