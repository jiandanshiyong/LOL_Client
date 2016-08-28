//
//  NewsListViewController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "NewsListViewController.h"
#import "CONSTS.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "RecommModel.h"
#import "AdCell.h"
#import "YCRefreshControl.h"
#import "NewsDetailViewController.h"


@interface NewsListViewController ()<UITableViewDataSource, UITableViewDelegate, ADCellDelegate>{
    UITableView *_tableView;
    
    NSMutableArray *_arrayDS; //数据源
    NSMutableArray *_arrayAD; //AD广告
    
    NSInteger _currentPage; //记录当前的页数
    BOOL _isUP;  //记录上拉/下拉?  YES：上拉  NO：下拉
}

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    [self initUI];
    
    [_tableView yc_beginRefresh]; //开始刷新，第一次进入界面自动调用下拉刷新
}

#pragma mark - 初始化
- (void)initData{
    _arrayDS = [[NSMutableArray alloc] init];
    _arrayAD = [[NSMutableArray alloc] init];
    _currentPage = 1; //默认加载第一页
}

- (void)initUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SWIDTH, SHEIGHT-49-44-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    //提前注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    [_tableView registerClass:[AdCell class] forCellReuseIdentifier:@"AdCell"];
    
    [self addHeaderAndFooterRefresh]; //添加上拉下拉视图
}

- (void)addHeaderAndFooterRefresh{
    // 上拉
    [_tableView yc_setLoadmoreAction:^{
        _isUP = YES;
        
        //触发上拉刷新之后， 执行的内容
        _currentPage ++;
        [self downloadData];
        
    }];
    
    //下拉 header
    [_tableView yc_setRefreshAction:^{
        _isUP = NO;
        
        _currentPage = 1;//回到首页面
        [self downloadData];//
    }];

}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayDS.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        AdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdCell"];
        cell.delegate = self;
        
        cell.adSourceArr = _arrayAD;
        return cell;
    }else{
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" ];
        cell.model = _arrayDS[indexPath.row-1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160; //广告cell高度
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //取消选中效果
    
    NewsModel *model = _arrayDS[indexPath.row-1];
    
    NewsDetailViewController *newsDVC = [[NewsDetailViewController alloc] init];
    newsDVC.newsId = model.myId;
    [self.navigationController pushViewController:newsDVC animated:YES];
}


#pragma mark - ADCellDelegate
- (void)didSelectAdCellWithId:(NSString *)newsId{
    NewsDetailViewController *newsDVC = [[NewsDetailViewController alloc] init];
    newsDVC.newsId = newsId;
    [self.navigationController pushViewController:newsDVC animated:YES];
}


#pragma mark -  下载数据
- (void)downloadData{
    NSString *urlStr;
    
    switch (self.type) {
        case latestPage:
            urlStr = [NSString stringWithFormat:kLatestNewsUrlString,_currentPage]; //最新
            break;
        case ActivePage:
            urlStr = [NSString stringWithFormat:kS4UrlString,_currentPage]; //活动
            break;
        case GamePage:
            urlStr = [NSString stringWithFormat:kMatchUrlStirng,_currentPage]; //赛事
            break;
        case VideoPage:
            urlStr = [NSString stringWithFormat:kGreatUrlString,_currentPage]; //视频
            break;
        case EnjoyPage:
            urlStr = [NSString stringWithFormat:kLolPictureUrlString,_currentPage]; //娱乐
            break;
        case Officalpage:
            urlStr = [NSString stringWithFormat:kOfficialUrlString,_currentPage]; //官方
            break;
        case BeautyPage:
            urlStr = [NSString stringWithFormat:kBeautifulGirlUrlString,_currentPage]; //美女
            break;
        case StrategyPage:
            urlStr = [NSString stringWithFormat:kStrategyUrlString,_currentPage]; //攻略
            break;
            
        default :
            break;
    }
    
    //网络请求  并解析数据
    [NetManager GET:urlStr parameters:nil success:^(id responseObject) {
        
        //解析：responseObject
        [self parseData:responseObject];
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error.description);
    }];
    
}

//数据解析
- (void)parseData:(NSData *)data{
    // 编辑判断， 容错处理
    if(!data){
        return;
    }
    
    //下拉刷新 需要清空数据
    if (!_isUP) {
        [_arrayDS removeAllObjects];
        [_arrayAD removeAllObjects];
    }
    
    NSDictionary *root  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *errorCode = root[@"error_code"];
    
    if ([errorCode integerValue] == 0) {
        
        //cell list
        for (NSDictionary *dic in root[@"result"]) {
            NewsModel *model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];   //映射
            [_arrayDS addObject:model];
        }
        
        //ad list
        for (NSDictionary *dic in root[@"recomm"]) {
            RecommModel *model = [[RecommModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_arrayAD addObject:model];
        }
        
        //刷新数据源
        [_tableView reloadData];
        
        //结束刷新动作
        [_tableView yc_endLoadmore]; //上拉结束
        [_tableView yc_endRefresh];  //下拉结束
    } else{
        NSLog(@"数据获取失败");
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
