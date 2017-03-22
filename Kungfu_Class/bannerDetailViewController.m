//
//  bannerDetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 10/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "bannerDetailViewController.h"

@interface bannerDetailViewController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation bannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, P_Width,p_hight)];
    
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
