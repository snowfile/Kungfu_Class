//
//  agreementViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/30/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "agreementViewController.h"

@interface AgreementViewController (){
    UIWebView *webView;
}

@end

@implementation AgreementViewController

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"用户协议";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAgreementView];
}
-(void)initAgreementView{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.scrollView.bounces = YES;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"KFDeclaration.rtf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
