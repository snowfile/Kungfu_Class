//
//  VisitDetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 09/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "VisitDetailViewController.h"
#import <MessageUI/MessageUI.h>

@interface VisitDetailViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation VisitDetailViewController{
    UIView *revisitHeadView;
    UIView *visitMiddleView;
    UIView *visitFootView;
    
    NSString *phoneNum;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者回访";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    if (self.flag == 100) {
            [self createNaviButton];
        }
    NSLog(@"visitArray=====%@",_rebackArray);
    [self createView];
    [self showData];

}
-(void)getData{
    NSString *urlString = [NSString stringWithFormat:@"visit/%@/info.do",self.rebackId];
    [NetService requestURL:urlString httpMethod:@"POST" params:nil completion:^(id result,NSError *error){
        NSString *status = result[@"resultCode"];
        NSDictionary *data = result[@"data"];
        if ([status isEqualToString:@"0"]) {
            NSDictionary *patientInfo = data[@"patientInfo"];
            phoneNum = patientInfo[@"mobile"];
        }
    }];
}
-(void)createNaviButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 70, 40);
    [button setTitle:@"填写记录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button addTarget:self action:@selector(writeRecord) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark=====填写记录
-(void)writeRecord{

    
}
-(void)createView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];

    revisitHeadView = [[[NSBundle mainBundle] loadNibNamed:@"RevisitHeadView" owner:nil options:nil]firstObject];
    revisitHeadView.backgroundColor = [UIColor whiteColor];
    revisitHeadView.frame = CGRectMake(0, 0, P_Width, 100);
    
    [scrollView addSubview:revisitHeadView];
    
    //确认回访
    visitMiddleView = [[[NSBundle mainBundle]loadNibNamed:@"visitMiddleView" owner:nil options:nil]firstObject];
    visitMiddleView.backgroundColor = [UIColor whiteColor];
    visitMiddleView.frame = CGRectMake(0, revisitHeadView.bottom+8, P_Width, 273);
    [scrollView addSubview:visitMiddleView];
    
    visitFootView = [[[NSBundle mainBundle]loadNibNamed:@"visitMiddleView" owner:nil options:nil]lastObject];
    visitFootView.backgroundColor =[UIColor whiteColor];
    visitFootView.userInteractionEnabled = YES;
    visitFootView.frame = CGRectMake(0, visitMiddleView.bottom+8, P_Width, 193);
    [scrollView addSubview:visitFootView];
    scrollView.contentSize = CGSizeMake(P_Width, visitFootView.bottom+20);

}
-(void)showData{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:_rebackArray[@"patientIcon"]]];
    NSURL *url = [NSURL URLWithString:urlString];
    UIImageView *imageView =(UIImageView *)[revisitHeadView viewWithTag:1001];
    imageView.layer.cornerRadius = imageView.width/2;
    imageView.layer.masksToBounds = YES;
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"information_head"]];
    
    UILabel *nameLabel = (UILabel *)[revisitHeadView viewWithTag:1002];
    nameLabel.text = _rebackArray[@"patientName"];
    
    UILabel *idLabel = (UILabel *)[revisitHeadView viewWithTag:1003];
    idLabel.text = [NSString stringWithFormat:@"健康ID:%@",_rebackArray[@"patientCode"]];

    
    UILabel *labelOne = (UILabel *)[visitMiddleView viewWithTag:2001];
    labelOne.text = _rebackArray[@"visitDate"];
    
    UILabel *labelTwo = (UILabel *)[visitMiddleView viewWithTag:2002];
    labelTwo.text = _rebackArray[@"content"];
    
    UILabel *labelThree = (UILabel *)[visitMiddleView viewWithTag:2003];
    
    UILabel *labelForth = (UILabel *)[visitMiddleView viewWithTag:2004];
    labelForth.text = _rebackArray[@"visitorName"];
    
    UIButton *phoneBtn = (UIButton *)[visitFootView  viewWithTag:3001];
    [phoneBtn addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *messageBtn = (UIButton *)[visitFootView  viewWithTag:3002];
    [messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)phoneAction{
    UIWebView *callView = [[UIWebView alloc] init];
    NSString *phone = [NSString stringWithFormat:@"tel:%@",phoneNum];
    NSURL *telURL = [NSURL URLWithString:phone];
    [callView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callView];
}
-(void)messageAction{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    controller.recipients = @[phoneNum];
    controller.body = @"[功夫牙医]回访短信:";
    controller.navigationBar.tintColor = [UIColor redColor];
    controller.messageComposeDelegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    }else if (result == MessageComposeResultSent){
        NSLog(@"已经发出");
    }else{
        NSLog(@"发送失败");
    }
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
