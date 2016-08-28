//
//  LoginViewController.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "LoginViewController.h"
#import "RDVTabBarController.h"
#import "RegisterViewController.h"
#import "UIViewExt.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *accountTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号登陆";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = YES;
    
    //注册键盘事件监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UITextField *textField = [self findFirstResponse];
    [textField resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 键盘 出现/消失
- (void)keyboardAppear:(NSNotification *)notification{
    //获取键盘的高度
    NSValue *keyboardValue =[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame=[keyboardValue CGRectValue];
    float height =frame.size.height;
    
    //第一响应者textField的frame
    UITextField *textField = [self findFirstResponse];
    if (textField.bottom > SHEIGHT- height) {
        //调整、适应键盘的高度
        [UIView animateWithDuration:0.25 animations:^{
            self.view.bottom = SHEIGHT - (textField.bottom - (SHEIGHT- height))-100;
        }];
    }
}

- (void)keyboardHide:(NSNotification *)notification{
    //调整、适应键盘的高度
    [UIView animateWithDuration:0.25 animations:^{
        self.view.bottom = SHEIGHT;
    }];
    
}

- (UITextField *)findFirstResponse{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if ([textField isFirstResponder]) {
                return textField;
            }
        }
    }
    return nil;
}


#pragma mark - 登录
- (IBAction)loginAction:(id)sender {
}


#pragma mark - 注册
- (IBAction)registerAction:(id)sender {
    
    RegisterViewController *registVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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
