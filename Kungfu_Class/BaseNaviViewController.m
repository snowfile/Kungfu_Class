//
//  BaseNaviViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 22/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBackBtnWithLowImage:@"返回" andHeightImage:@"返回"];
}
-(void)changeBackBtnWithLowImage:(NSString *)lowImage andHeightImage:(NSString *)heightImage{
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 18, 18);
    
    [but setImage:[UIImage imageNamed:lowImage] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(leftNavButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftNavButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
