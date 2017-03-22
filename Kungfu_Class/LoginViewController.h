//
//  LoginViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 12/19/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController

@property(nonatomic,copy)NSString *phoneString;
@property(nonatomic,copy)NSString *pwdString;
@property (strong, nonatomic) IBOutlet UITextField *phone_filed;
@property (strong, nonatomic) IBOutlet UITextField *pwd_field;
@property (weak, nonatomic) IBOutlet UIButton *login_Btn;

- (IBAction)loginBtnClick:(UIButton *)sender;



@end
