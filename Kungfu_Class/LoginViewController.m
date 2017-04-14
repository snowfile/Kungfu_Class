//
//  LoginViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/19/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseTabViewController.h"
#import "ForgetPwdViewController.h"
#import "homeViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "Single.h"

@interface LoginViewController ()
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.login_Btn.layer.cornerRadius = 9;
    self.login_Btn.clipsToBounds = YES;
    self.phone_filed.text = self.phoneString;
    self.pwd_field.secureTextEntry = YES;
    //显示密码
    NSString *username = [USERDEFAULTS objectForKey:@"user"];
    NSString *password = [USERDEFAULTS objectForKey:@"pass"];
    if (![username isEqualToString:@""]&&![password isEqualToString:@""]) {
       _phone_filed.text = username;
        _pwd_field.text = password;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

-(IBAction)loginBtnClick:(UIButton *)sender{
    
    if (_phone_filed.text.length == 0|| _pwd_field.text.length == 0) {
        [KVNProgress showErrorWithStatus:@"请将账号或密码填写完整"];
        return;
    }
    if (![NSString checkTelNumber:_phone_filed.text]) {
        [KVNProgress showErrorWithStatus:@"手机号输入不正确"];
        return;
    }
    NSDictionary *param = @{@"mobile":_phone_filed.text,@"password":[_pwd_field.text MD5]};
    [NetService requestURL:@"/school/api/account/login" httpMethod:@"POST" params:param completion:^(id result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
          NSString *resultDesc = [result objectForKey:@"resultDesc"];
      
        //登录成功
        if ([status isEqualToString:@"0"]||self.presentationController != nil){
        
            NSDictionary *data = [result objectForKey:@"data"];
            NSString *accountid = data[@"accountId"];
            
            NSDictionary *userInfo = data[@"userInfo"];
            NSString *userid = userInfo[@"userId"];
            
            UserModel *userModel = [UserModel sharedInstance];
            [userModel setToken:data[@"token"]];
            [userModel setAccountId:accountid];
            [UserModel  setPhysicalInfo:data[@"physicianInfo"]];
            [userModel setUserId:userid];
            [userModel setToken:data[@"token"]];
            
            Single  *single = [Single shareSingle];
            [single setAccountId:accountid];
            
            if ([data[@"physicianInfo"] isKindOfClass:[NSDictionary class]]) {
                
                NSString *physicalId = data[@"physicianInfo"][@"physicianId"];
                [userModel setPhysicalId:physicalId];
                NSArray *phsyArray = data[@"physicianInfo"][@"hList"];
                [single setPhysicalId:physicalId];
                if (phsyArray != nil) {
                    NSDictionary *firstDict = [phsyArray firstObject];
                    NSString *doctorId = firstDict[@"doctorId"];
                    NSString *doctorName = firstDict[@"doctorName"];
                    NSString *hospitalId = firstDict[@"hospitalId"];
                    NSString *hosipitalName = firstDict[@"hospitalName"];

                    [single setHosipitalId:hospitalId];
                    [single setHospitalName:hosipitalName];
                    [single setDoctorId:doctorId];
                    [single setDoctorName:doctorName];
                    
                }
                BaseTabViewController *baseView = [BaseTabViewController shareInstance];
                
                 homeViewController *home = [[homeViewController alloc]init];
                               home.tabBarItem = baseView.tabBarItem;
                [self dismissViewControllerAnimated:YES completion:nil];
        [self presentViewController:baseView animated:YES completion:nil];
        //保存用户名密码
            [USERDEFAULTS setObject:_phone_filed.text forKey:@"user"];
            [USERDEFAULTS synchronize];
            [USERDEFAULTS setObject:_pwd_field.text forKey:@"pass"];
            [USERDEFAULTS synchronize];
            }
        }else{
            [KVNProgress showErrorWithStatus:resultDesc];
            return ;
        }
            }];
}
- (IBAction)regist_Event:(id)sender {
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [regist setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    UIBarButtonItem *bacBtn = [[UIBarButtonItem alloc] init];
    bacBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = bacBtn;
    [self presentViewController:regist animated:YES completion:nil];
}
- (IBAction)forgetpwd_Event:(id)sender {
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ForgetPwd" bundle:nil];
    ForgetPwdViewController *forgetPwd = (ForgetPwdViewController *) [storyboard instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
    [self presentViewController:forgetPwd animated:YES completion:nil];
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
