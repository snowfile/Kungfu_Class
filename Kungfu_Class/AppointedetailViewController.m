//
//  AppointedetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 20/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "AppointedetailViewController.h"


@interface AppointedetailViewController ()

@end

@implementation AppointedetailViewController{
    
    UIImageView *imageView;



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预约详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createView];
    [self showData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [imageView removeFromSuperview];
}
-(void)createView{

    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58, P_Width, 55)];
    imageView.image = [UIImage imageNamed:@"提示-背景"];
    [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(P_Width/2-60, 15, 25, 25)];
    imageV.image = [UIImage imageNamed:@"提示-对号"];
    [imageView addSubview:imageV];
    
    UILabel *labelV =[[UILabel alloc ] initWithFrame:CGRectMake(P_Width/2-25, 18, 100, 20)];
    if (self.tag == 101) {
        labelV.text = @"预约未到!";
    }else if (self.tag == 102) {
        labelV.text = @"预约超时";
    }else {
        labelV.text = @"预约已完成";
    }
    labelV.textColor = [UIColor whiteColor];
    labelV.font = [UIFont systemFontOfSize:17];
    [imageView addSubview:labelV];
}

-(void)showData{



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
