//
//  AdviceViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 1/10/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()<UITextFieldDelegate>{
    UILabel *topLabel;
    UITextView *adviceTextView;
    UIButton *submitBtn;


}

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTitleAndBackItem:@"意见反馈"];
    [self initAdviceView];
    
}
-(void) initAdviceView{
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 60, P_Width-16,50)];
    topLabel.text = strTopLabelInAdvice;
    topLabel.textColor = [UIColor lightGrayColor];
    topLabel.font = [UIFont systemFontOfSize:12];
    topLabel.numberOfLines = 0;
    topLabel.lineBreakMode = 0;
    [self.view addSubview:topLabel];
    
    
    adviceTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 112, P_Width-20, 200)];
   
    adviceTextView.layer.borderWidth = 0.5;
    adviceTextView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [self.view addSubview:adviceTextView];
    

    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(10, 325, P_Width-20, 40);
    [submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 10;
    submitBtn.titleLabel.textColor = [UIColor whiteColor];
    [submitBtn setBackgroundColor:bg_color];
    [self.view addSubview:submitBtn];


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
