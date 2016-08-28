//
//  SettingsViewController.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "RDVTabBarController.h"

@interface SettingsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_arrayDS;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"settingList.plist" ofType:nil];
    _arrayDS = [[NSMutableArray alloc] initWithContentsOfFile:path];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
}


#pragma mark - UITableViewDataSource, UITableViewDelegat

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayDS.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayDS[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
    }
    
    //填充数据
    NSDictionary *dic = [_arrayDS[indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"desc"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0 && indexPath.row ==0) {
        [self loginByPhone];
    }
}


#pragma mark - cell action

- (void)loginByPhone{
    LoginViewController *loginVC = [[LoginViewController alloc] init];

    [self.navigationController pushViewController:loginVC animated:YES];
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
