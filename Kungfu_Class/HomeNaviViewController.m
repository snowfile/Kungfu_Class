//
//  HomeNaviViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "HomeNaviViewController.h"
#import "homeViewController.h"

@interface HomeNaviViewController ()

@end

@implementation HomeNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customMakeNavigationBar];
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    if([super init]){
    homeViewController *homeView = [homeViewController new];
        self = [super initWithRootViewController:homeView];
    }
    return self;
}
-(void)customMakeNavigationBar{
    self.navigationBar.barTintColor = bg_color;
    self.navigationBar.translucent = NO;
    
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
