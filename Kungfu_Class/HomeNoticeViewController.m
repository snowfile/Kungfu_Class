//
//  HomeNoticeViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 2/14/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "HomeNoticeViewController.h"

@interface HomeNoticeViewController ()

@end

@implementation HomeNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"消息中心";
    [self loadNullPage];
}
-(void)loadNullPage{
    UIImageView *nilImg = [[UIImageView alloc] initWithFrame:CGRectMake(P_Width/2-50, p_hight/2-140, 100, 100)];
    nilImg.image = [UIImage imageNamed:@"no_data"];
    [self.view addSubview:nilImg];




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
