//
//  RegisterViewController.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegularHelp.h"
#import "SVProgressHUD.h"
#import "DES3Util.h"

@interface RegisterViewController (){
  NSString *_tempuid;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"注册";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - 发送验证码
- (IBAction)sendVertifyCode:(id)sender {
    
    //1.逻辑判断
    //1.1 所有内容不能为空
    //1.2 两次输入密码必须一致
    //1.3 手机号 11位数字  正则校验
    if (![RegularHelp validateUserPhone:_phoneTextField.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号格式不正确" duration:1.4];
        return;
    }
    
    //本地条件全部满足
    //http://api.d1cm.com/appaccount/register.action?mobile=?&pwd=?&username=?
    NSString *urlStr = @"http://api.d1cm.com/appaccount/register.action";
    NSDictionary *paramDic = @{@"mobile" : [DES3Util encrypt:self.phoneTextField.text] ,
                               @"pwd" : [DES3Util encrypt:self.pwdAgainTextField.text],
                               @"username" : [DES3Util encrypt:self.accountTextField.text]};
    
    [NetManager POST:urlStr parameters:paramDic success:^(id responseObject) {
        /**
         {
         "info":[
         "status":"1",
         "message":"注册合法有效",
         "tempuid":"1"
         ]
         }
         */
        
        NSDictionary *root  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil ];
        NSDictionary *infoDic = root[@"info"][0];
        
        NSString *status = infoDic[@"status"];
        NSString *message = infoDic[@"message"];
        _tempuid = infoDic[@"tempuid"];
        
        if ([status integerValue]  == 1) {
            [SVProgressHUD showSuccessWithStatus:message duration:1.7];
        }
        else{
            [SVProgressHUD showErrorWithStatus:message duration:1.7];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 注册账号

- (IBAction)registerAction:(id)sender {
    /**
     *  http://api.d1cm.com/appaccount/checkcode.action?tempuid=?&code=?
     *
     *  {
         "info":[
                 "status":"1",
                 "message":"注册成功"
                 "userid":"1"
                ]
         }
     */
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
