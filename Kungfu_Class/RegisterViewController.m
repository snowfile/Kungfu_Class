//
//  RegisterViewController.m
//  DentalDoc
//
//  Created by pengpeng on 16/7/22.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "AgreementViewController.h"
#import "BaseTabViewController.h"
#import "AppDelegate.h"


@interface RegisterViewController ()

@end
@implementation RegisterViewController {
    
    __weak IBOutlet UITextField *_phoneField;
    __weak IBOutlet UITextField *_wordField;
    __weak IBOutlet UITextField *_codeField;
    
    NSInteger _currentTime;
    BOOL _isSending;
    NSTimer *_myTimer;
    BOOL chage;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _wordField.textColor = FIELDCOLOR;
    _phoneField.textColor = FIELDCOLOR;
    _codeField.textColor = FIELDCOLOR;
    
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.layer.cornerRadius = 5;
    self.codeButton.backgroundColor = COLOR;
    self.codeButton.titleLabel.textColor = [UIColor whiteColor];
    
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 10;
    
    self.agreeButton.titleLabel.textColor = BLUETEXTCOLOR;
    self.loginNow.titleLabel.textColor = BLUETEXTCOLOR;
    
    [self.eyeButton setImage:[UIImage imageNamed:@"眼睛-深"] forState:UIControlStateSelected];
    [self.eyeButton addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"欢迎注册";
}
-(void)showOrHide:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _wordField.secureTextEntry = NO;
    }else{
        _wordField.secureTextEntry = YES;
    }
}
- (IBAction)sendValidateCode:(id)sender {
    if ([_phoneField.text isEqualToString:@""]||![NSString checkTelNumber:_phoneField.text]) {
        [KVNProgress showErrorWithStatus:@"不能为空"];
    }else{
        [self keyboardHidden];
        _isSending = YES;
        _currentTime = 60;
        if (_isSending) {
            if (!_myTimer) {
                _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
            }else{
                [_myTimer setFireDate:[NSDate distantPast]];
            }
            _codeButton.titleLabel.text = [NSString stringWithFormat:@"%lds后重发",(long)_currentTime];
            _codeButton.backgroundColor = [UIColor grayColor];
            _codeButton.enabled = NO;
        }
    }
    NSString *phone = _phoneField.text;
     NSString *url = [NSString stringWithFormat:@"dentist/api//common/getVerifyCode.do?mobile=%@",phone];
    [NetService requestURL:url httpMethod:@"GET" params:nil completion:^(id result,NSError *error){
    }];
}
-(void)countDown{
    _currentTime--;
    if (_currentTime > 0) {
        NSString *text = [NSString stringWithFormat:@"%ld秒后重发",(long)_currentTime];
        _codeButton.titleLabel.text =  text;
        [_codeButton setTitle:text forState:UIControlStateNormal];
    }
    if (_currentTime == 0) {
        [self restSmgBtn];
    }
}
-(void)restSmgBtn{
    [_myTimer setFireDate:[NSDate distantPast]]; //不可达到的过去的某个时间点
    [_myTimer invalidate];
    _myTimer = nil;
    _isSending = NO;
    _currentTime = 60;
    _codeButton.titleLabel.text = @"发送验证码";
    _codeButton.backgroundColor = COLOR;
    [_codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _codeButton.enabled = YES;
}
#pragma mark 注册事件
- (IBAction)finish_Regist:(id)sender {
    [self keyboardHidden];
    if ([_phoneField.text isEqualToString:@""]||![NSString checkTelNumber:_phoneField.text]||[_codeField.text isEqualToString:@""]||[_wordField.text isEqualToString:@""]||![NSString checkPassword:_wordField.text]) {
        if ([_phoneField.text isEqualToString:@""]) {
            [KVNProgress showErrorWithStatus:@"手机号不能为空"];
            return;
        }else if (![NSString checkTelNumber:_phoneField.text]) {
            [KVNProgress showErrorWithStatus:@"手机号不正确"];
            return;
        }else if ([_codeField.text isEqualToString:@""]) {
            [KVNProgress showErrorWithStatus:@"验证码不能为空"];
            return;
        }else if ([_wordField.text isEqualToString:@""]){
            [KVNProgress showErrorWithStatus:@"密码不能为空"];
            return;
        }else {
            [KVNProgress showErrorWithStatus:@"密码过于简单"];
            return;
        }
    }else {
        NSDictionary *param = @{@"mobile":_phoneField.text,
                                @"password":_wordField.text,
                                @"verifyCode":_codeField.text
        };
        [NetService requestURL:@"school/api/account/register" httpMethod:@"POST" params:param completion:^(id result,NSError *error){
            NSLog(@"error=====%@",[error description]);
            NSLog(@"result=======%@",result);
            NSString *statusCode = [result objectForKey:@"resultCode"];
            NSString *resultDesc = [result objectForKey:@"resultDesc"];
            if ([statusCode isEqualToString:@"0"]) {
                NSString *statusCode = [result objectForKey:@"resultCode"];
                if ([statusCode isEqualToString:@"0"]) {
                    [KVNProgress showErrorWithStatus:@"注册成功"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
                    LoginViewController *loginView = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    loginView.phoneString = _phoneField.text;
                    loginView.pwdString = _wordField.text;
                    [self.navigationController pushViewController:loginView animated:YES];
//                    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
//                    NSString *restr = [[NSString alloc] initWithData:result encoding:enc];
//                    
//                   
                }
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
//                LoginViewController *loginView = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
//                nav.navigationBar.barTintColor = bg_color;
//                 [self presentViewController:nav animated:YES completion:nil];
            }else if (![statusCode isEqualToString:@"0"]){
            
                [KVNProgress showErrorWithStatus:resultDesc];
            }
        }];
    }

}

- (IBAction)showAgreement:(id)sender {
    AgreementViewController *agreeMent = [[AgreementViewController alloc] init];
    UIBarButtonItem *bacButton = [[UIBarButtonItem alloc] init];
    bacButton.title = @"返回";
    self.navigationItem.backBarButtonItem = bacButton;
    [self.navigationController pushViewController:agreeMent animated:YES];
}
- (IBAction)logonNow:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *loginView = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginView animated:YES];
}
#pragma mark =====隐藏键盘
-(void)keyboardHidden{
    [_phoneField resignFirstResponder];
    [_codeButton resignFirstResponder];
    [_wordField resignFirstResponder];
}
@end
