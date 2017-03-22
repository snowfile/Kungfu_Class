//
//  BaseTabViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "BaseTabViewController.h"

@interface BaseTabViewController ()

@end

@implementation BaseTabViewController
+(instancetype)shareInstance{
    static BaseTabViewController *baseTabViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseTabViewController = [[BaseTabViewController alloc] init];
    });
    return baseTabViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithTabbar];
}
-(void)initWithTabbar{


    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;

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
