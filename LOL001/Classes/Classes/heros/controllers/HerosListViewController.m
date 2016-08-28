//
//  HerosListViewController.m
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//


#import "HerosListViewController.h"
#import "HeroModel.h"
#import "MagicalRecord.h"
#import "CONSTS.h"
#import "HeroCell.h"

#define GAP 5  //间距
#define COLUMN 2  //列


@interface HerosListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>{
    NSMutableArray *_arrayDS;
    UICollectionView *_collectionView; //网格列表
    
    UISearchBar *_searchBar;
    NSArray *_searchResultArr;   // 搜索的结果
    BOOL _isActive; // 用来记录搜索框的状态
}

@end

@implementation HerosListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData{
    NSArray * arr = [HeroModel MR_findAll];
    if(arr.count > 0){
        // 有缓存数据
        _arrayDS = [[NSMutableArray alloc] initWithArray:arr];
    }
    else{
        // 没有缓存，下载数据
        [self downloadData];
    }
}

- (void)initUI{
    // 添加搜索框
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = @"请输入英雄的名字";
    [self.view addSubview:_searchBar];
    
    
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //创建网格视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+44, SWIDTH, SHEIGHT-49-64-44) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"HeroCell" bundle:nil] forCellWithReuseIdentifier:@"HeroCell"];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _isActive = YES;
}

// 搜索框文本内容发生改变 被调用的方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@", searchText);
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS %@", searchText];
    _searchResultArr = [HeroModel MR_findAllWithPredicate:predicate];
    
    // 刷新表
    [_collectionView reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isActive = NO;
    
    [_collectionView reloadData];
    
    [_searchBar resignFirstResponder];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_isActive){
        return [_searchResultArr count];
    }
    return [_arrayDS count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HeroCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeroCell" forIndexPath:indexPath];
    
    if(_isActive){
        // 传递数据
        cell.model = _searchResultArr[indexPath.row];
    }
    else{
        // 传递数据
        cell.model = _arrayDS[indexPath.row];
    }
    
    return cell;
}

//item 大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (SWIDTH - COLUMN * GAP * 2) / COLUMN;
    return CGSizeMake(width, 80);
}

//item 内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(GAP, GAP, GAP, GAP);
}

// 行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}


#pragma mark - 下载数据
- (void)downloadData{
    
    NSString *urlStr;
    if (_type == LimitHero) {
        urlStr = kFreeHeroUrlString;
    }else{
        urlStr = kAllHeroUrlString;
    }
    
    
    [NetManager GET:urlStr parameters:nil success:^(id responseObject) {
        //解析数据
        [self parserData: responseObject];
    } failure:^(NSError *error) {
        NSLog(@"ERR: %@", error.description );
    }];

    
}

- (void)parserData:(NSData *)data{
    if (!data) {
        return;
    }
    
    NSDictionary *root  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString * errorCode = root[@"error_code"];
    if ([errorCode integerValue] == 0) {
        
        _arrayDS = [NSMutableArray new];
        
        for (NSDictionary *dic in root[@"result"]) {
            HeroModel *model = [HeroModel MR_createEntity];
            model.myId   = dic[@"id"];
            model.name_c = dic[@"name_c"];
            model.title  = dic[@"title"];
            model.img    = dic[@"img"];
            model.tags   = dic[@"tags"];
            
            [_arrayDS addObject:model];
        }
        
        //将数据存入数据源中
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        //刷新UI
        [_collectionView reloadData];
        NSLog(@"count = %ld", _arrayDS.count);
        
    }else{
        NSLog(@"解析失败");
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
