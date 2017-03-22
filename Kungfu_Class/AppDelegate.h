//
//  AppDelegate.h
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"
#import "HomeNaviViewController.h"
#import "ClassNaviViewController.h"
#import "SchemeNaviViewController.h"
#import "MineNaviViewController.h"
#import "WelcomeViewController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)BaseTabViewController *baseTabViewController;


@end

