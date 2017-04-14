//
//  AppDelegate.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@property (nonatomic,strong)BaseTabViewController *baseTabController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        NSLog(@"联网成功");
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前网络不给力,请检查重试" preferredStyle:UIAlertControllerStyleAlert];
        [self.window addSubview:alert.view];
    }

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

//    _baseTabController = [[BaseTabViewController alloc] init];
    
    HomeNaviViewController *homeNavi = [[HomeNaviViewController alloc] initWithRootViewController:[BaseTabViewController shareInstance]];
    ClassNaviViewController *classNavi = [[ClassNaviViewController alloc] initWithRootViewController:[BaseTabViewController shareInstance]];
    SchemeNaviViewController *schemeNavi = [[SchemeNaviViewController alloc] initWithRootViewController:[BaseTabViewController shareInstance]];
    MineNaviViewController *mineNavi = [[MineNaviViewController alloc] initWithRootViewController:[BaseTabViewController shareInstance]];
    
    [[BaseTabViewController shareInstance] setViewControllers:@[homeNavi,classNavi,schemeNavi,mineNavi]];
  
  //启动防止崩溃功能
    [AvoidCrash becomeEffective];
    
    BOOL isLauch = [USERDEFAULTS boolForKey:@"isLauch"];
    if (!isLauch) {
        WelcomeViewController *welcomeView = [[WelcomeViewController alloc] init];
        self.window.rootViewController = welcomeView;
        [self.window makeKeyAndVisible];
        [USERDEFAULTS setBool:YES forKey:@"isLauch"];
        //将userdefaults中存储的数据，同步到本地的文件中去
        [USERDEFAULTS synchronize];
    }else{
        [self setupLoginViewController];
    }
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupLoginViewController) name:@"beginLogin" object:nil];
    
    //IQKeyboardManager键盘事件
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;

    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic){
            NSLog(@"result = %@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSString *memo = resultDic[@"memo"];
            if ([resultStatus isEqualToString:@"90000"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:nil];
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payError" object:memo];
            }
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 登录

-(void)setupLoginViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *loginView = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
 

    if ([UIApplication sharedApplication].delegate.window.rootViewController.presentedViewController == nil) {
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:loginView animated:YES completion:^{
        }];
    }   self.window.rootViewController = loginView;
        [self.window makeKeyAndVisible];
}



@end
