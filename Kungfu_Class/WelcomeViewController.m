//
//  WelcomeViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/20/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController (){
    UIPageControl *pageControl;
    UIScrollView *scrollView;
    UIButton *_enterBtn;
    UIButton *_skipBtn;
    NSArray *_imageName;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageName = @[@"page_1",@"page_2",@"page_3"];
    [self creatWelcomeView];
    
}
-(void)creatWelcomeView{
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((P_Width-150)/2,p_hight-20, 150, 0)];
    pageControl.numberOfPages = _imageName.count;
    pageControl.currentPageIndicatorTintColor = pageControl_color;
    pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:pageControl];

    //进入按钮
    _enterBtn = [[UIButton alloc] init];
    _enterBtn.tag = 100;
    _enterBtn.hidden = YES;
    _enterBtn.frame = CGRectMake((P_Width-80)/2, p_hight-100, 80, 50);
    [_enterBtn setImage:[UIImage imageNamed:@"go"] forState:UIControlStateNormal];
    //    [_enterBtn setTitleColor:UIColoerFromRGB(0x53b8e4) forState:UIControlStateNormal];
    [_enterBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    _enterBtn.layer.masksToBounds = YES;
    //    _enterBtn.layer.cornerRadius = 4;
    //    _enterBtn.layer.borderWidth = 1;
    //    _enterBtn.layer.borderColor = UIColoerFromRGB(0x53b8e4).CGColor;
    [self.view addSubview:_enterBtn];

    
    for (int i = 0; i<_imageName.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.image = [UIImage imageNamed:_imageName[i]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        //跳过按钮
        UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        skipButton.backgroundColor = [UIColor whiteColor];
        
        skipButton.layer.masksToBounds = YES;
        
        skipButton.layer.cornerRadius = 6;
        
        skipButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        skipButton.frame = CGRectMake(P_Width-48-20, 30, 48, 28);
        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        
        [skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [skipButton setTitleColor:UIColoerFromRGB(0x53b8e4) forState:UIControlStateNormal];
        
        [imageView addSubview:skipButton];
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*_imageName.count, 0);
    scrollView.pagingEnabled = YES;
}

- (void)skipAction:(UIButton *)button {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beginLogin" object:nil userInfo:nil];
}
-  (void)btnClick:(UIButton *)button {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beginLogin" object:nil userInfo:nil];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)ScrollView{
    
    pageControl.currentPage = scrollView.contentOffset.x /scrollView.frame.size.width;
    if (scrollView.contentOffset.x /P_Width == _imageName.count-1) {
        pageControl.hidden = YES;
        _enterBtn.hidden = NO;
    }else {
        _enterBtn.hidden = YES;
        pageControl.hidden = NO;
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
