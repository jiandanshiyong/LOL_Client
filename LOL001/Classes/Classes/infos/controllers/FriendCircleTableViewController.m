//
//  FriendCircleTableViewController.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "FriendCircleTableViewController.h"
#import "RDVTabBarController.h"
#import "GDataXMLNode.h"
#import "TweetModel.h"
#import "TweetFrameModel.h"
#import "TweetCell.h"
#import "YCRefreshControl.h"

@interface FriendCircleTableViewController (){
    NSMutableArray *_arrayDS;
    
    NSInteger _currentPage; //记录当前的页数
     BOOL _isUP;  //记录上拉/下拉?  YES：上拉  NO：下拉
}

@end

@implementation FriendCircleTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"朋友圈";
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    _arrayDS = [[NSMutableArray alloc] init];
    _currentPage = 1;
    
    [self addHeaderAndFooterRefresh]; //添加上拉下拉视图
    [self.tableView yc_beginRefresh]; //开始刷新，第一次进入界面自动调用下拉刷新
    
}

- (void)addHeaderAndFooterRefresh{
    // 上拉
    [self.tableView yc_setLoadmoreAction:^{
        _isUP = YES;
        
        //触发上拉刷新之后， 执行的内容
        _currentPage ++;
        [self downloadData];
        
    }];
    
    //下拉 header
    [self.tableView yc_setRefreshAction:^{
        _isUP = NO;
        
        _currentPage = 1;//回到首页面
        [self downloadData];//
    }];
    
}

#pragma mark - 数据下载 xml
- (void)downloadData{
    NSString *urlStr = [NSString stringWithFormat:kFriendCircleUrlString, _currentPage];
    
    [NetManager GET:urlStr parameters:nil success:^(id responseObject) {
        [self parseData:responseObject];
    } failure:^(NSError *error) {
         NSLog(@"下载失败。 Error: %@", error.description);
    }];
}

- (void)parseData:(NSData *)data{
    if (!data) {
        return;
    }
    
    //下拉刷新 需要清空数据
    if (!_isUP) {
        [_arrayDS removeAllObjects];
    }
    
    GDataXMLDocument *root = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *tweetEleArr = [root nodesForXPath:@"//tweet" error:nil];
    for (GDataXMLElement *ele in tweetEleArr) {
        TweetFrameModel *tfModel = [[TweetFrameModel alloc] init];
        tfModel.model = [[TweetModel alloc] initTweetByGDataXMLElement:ele];
        
        [_arrayDS addObject:tfModel];
    }
    
    [self.tableView reloadData];
    
    //结束刷新动作
    [self.tableView yc_endLoadmore]; //上拉结束
    [self.tableView yc_endRefresh];  //下拉结束
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"cell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    cell.tfmodel = _arrayDS[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetFrameModel *tfModel = _arrayDS[indexPath.row];
    return tfModel.totalHeight;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
