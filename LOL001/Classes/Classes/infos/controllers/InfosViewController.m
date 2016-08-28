//
//  InfosViewController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "InfosViewController.h"
#import "FriendCircleTableViewController.h"
#import "RDVTabBarController.h"

@interface InfosViewController ()<UITableViewDataSource, UITableViewDelegate>{

    NSMutableArray *_arrayDS;
}

@end

@implementation InfosViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载数据源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"infoCell" ofType:@"plist"];
    _arrayDS = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_arrayDS count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayDS[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //填充数据
    NSDictionary *dic = [_arrayDS[indexPath.section] objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:dic[@"iconImage"]];
    cell.textLabel.text = dic[@"title"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 0 && indexPath.row == 0) {
        [self showFriendCiecle];
    }
    
}


#pragma mark - 各个cell上的点击功能
- (void)showFriendCiecle{
    FriendCircleTableViewController *fcTVc = [[FriendCircleTableViewController alloc] init];
    
    [self.navigationController pushViewController:fcTVc animated:YES];
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
