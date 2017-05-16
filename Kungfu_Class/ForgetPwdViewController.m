//
//  forgetPwdViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/30/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "LoginViewController.h"

static NSString* const forgetPwd_URL = @"/school/api/account/forgetPassword";

@interface ForgetPwdViewController (){
    __weak IBOutlet UITextField *phone_textField;
    __weak IBOutlet UITextField *code_textField;
    __weak IBOutlet UITextField *pwd_textField;
    
    NSInteger _currentTime;
    BOOL _isSending;
    NSTimer *_myTimer;
    BOOL change;
}
@end
@implementation ForgetPwdViewController
-(void)viewWillAppear:(BOOL)animated{
    self.saveBtn.layer.cornerRadius = 9;
    self.saveBtn.clipsToBounds = YES;
    [self.eyeBtn setImage:[UIImage imageNamed:@"眼睛-深"] forState:UIControlStateSelected];
    [self.eyeBtn addTarget:self action:@selector(showOrhide:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"忘记密码";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendVerify_Code:(id)sender {
    
    if([phone_textField.text isEqualToString:@""]||![NSString checkTelNumber:phone_textField.text] ){
        [KVNProgress showErrorWithStatus:@"手机号有误"];
        return;
    }else{
        [self keyboardHidden];
        [KVNProgress showSuccessWithStatus:@"发送成功"];
        _isSending = YES;
        _currentTime = 60;
        if (_isSending) {
            if (!_myTimer) {
                _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
            }
            else{
                [_myTimer setFireDate:[NSDate distantFuture]];
            }
            _codeBtn.titleLabel.text = [NSString stringWithFormat:@"(%lds后重发",(long)_currentTime];
            _codeBtn.titleLabel.textColor = [UIColor grayColor];
            _codeBtn.enabled = NO;
        }
    }
    NSString *phone = phone_textField.text;
    NSString *url = [NSString stringWithFormat:@"dentist/api//common/getVerifyCode.do?mobile=%@",phone];
    [NetService requestURL:url httpMethod:@"GET" params:nil completion:^(id result,NSError *error){
    }];
}
- (IBAction)Forget_EdietPwd:(id)sender {

    NSDictionary *param = @{@"mobile":phone_textField.text,@"verifyCode":code_textField.text,@"newPassword":pwd_textField.text};
    [NetService requestURL:forgetPwd_URL httpMethod:@"POST" params:param completion:^(id result,NSError *error){
        NSLog(@"qinjing====%@",result);
        NSString *resultCode = [result objectForKey:@"resultCode"];
        NSString *resultDesc = [result objectForKey:@"resultDesc"];
        if ([resultCode  isEqualToString:@"0"]) {
            [KVNProgress showSuccessWithStatus:@"密码重置成功"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
            LoginViewController *loginView = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            loginView.phoneString = phone_textField.text;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
    }else if (![resultDesc isEqualToString:@"0"])
    {
        [KVNProgress showErrorWithStatus:resultDesc];
    }
    }];
}
-(void)countDown{
    _currentTime--;
    if (_currentTime > 0) {
        NSString *text = [NSString stringWithFormat:@"%lds后重发",(long)_currentTime]
        ;
        _codeBtn.titleLabel.text = text;
        [_codeBtn setTitle:text forState:UIControlStateNormal];
    }
    if (_currentTime == 0) {
        [self  restSmgBtn];
    }
}
-(void)restSmgBtn{
    [_myTimer setFireDate:[NSDate distantFuture]];
    [_myTimer invalidate];
    _myTimer = nil;
    _isSending = NO;
    _currentTime = 60;
    _codeBtn.titleLabel.text = @"发送验证码";
    _codeBtn.backgroundColor = [UIColor whiteColor];
    [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _codeBtn.enabled = YES;
}
#pragma mark 显示隐藏密码
-(void)showOrhide:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected == YES) {
        pwd_textField.secureTextEntry = NO;
    }else{
        pwd_textField.secureTextEntry = YES;
    }
}
-(void)keyboardHidden{
    [phone_textField resignFirstResponder];
    [code_textField resignFirstResponder];
    [pwd_textField resignFirstResponder];
}
- (IBAction)exit:(id)sender {
       [self dismissViewControllerAnimated:YES completion:nil];
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
