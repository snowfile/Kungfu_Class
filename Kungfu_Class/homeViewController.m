//
//  homeViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "homeViewController.h"
#import "SearchViewController.h"
#import "HomeNoticeViewController.h"
#import "teacherDetailViewController.h"
#import "bannerDetailViewController.h"
#import "teacherRecommedModel.h"
#import "courseRecommedModel.h"
#import "homeTeacherTable.h"
#import "classDetailViewController.h"

static NSString * const homeRecommedStrURL = @"/school/api/common/index_data";

@interface homeViewController (){
    UIScrollView  *bigScrollView;
    UIScrollView *smallScrollView;
    UIScrollView *bottonSrollView;
    UIPageControl  *pageControl;
    NSArray *imageArr;
    UITableView *middleTableview;
    UITableView *tailTableView;
    NSTimer *timer;
    UIImageView *imageViewTop;
    UIImageView *classImage;
    UIView *onImage;
    UILabel *nowPay;
    UILabel *oldPay;
    UILabel *className;
    UIView *homeClassView;
}
@property(nonatomic,strong)UITableView *teachTable;
@property(nonatomic,strong)UICollectionView *ClassCollectionView;
@property(nonatomic,strong)NSArray *bannerArray;
@property(nonnull,strong) NSMutableArray *courseList;
@property(nonnull,strong)NSMutableArray *teacherList;
@property(nonnull,strong)NSMutableArray *imgURL;
@property(nonatomic,strong)NSMutableArray *linkArray;
@end

@implementation homeViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeHome];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    [self requestDate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBarButton];
    [self initHomeView_Head];
}
-(void)requestDate{
    UserModel *usermodel = [UserModel sharedInstance];
    NSDictionary *dict = @{@"userId":[NSString stringIsNull:usermodel.userId]};
   
    [NetService requestURL:homeRecommedStrURL httpMethod:@"GET" params:dict completion:^(id
                                                                            result, NSError *error){
        NSLog(@"home==%@",result);
        NSString *resultCode = result[@"resultCode"];
         [bigScrollView.mj_header endRefreshing];
        if ([resultCode isEqualToString:@"0"]) {
            
           NSDictionary *data = result[@"data"];
            self.bannerArray = data[@"bannerList"];
            NSLog(@"bannnnaray====%@",self.bannerArray);
            NSMutableArray *mArray = [NSMutableArray array];
            NSMutableArray *linkArray = [NSMutableArray array];
            [_bannerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:dict[@"imageUrl"]]];
                NSString *linkURL = [NSString stringWithFormat:@"%@",dict[@"activityUrl"]];
                [mArray addObject:url];
                [linkArray addObject:linkURL];
            }];
            self.imgURL = mArray;
            self.linkArray = linkArray;
           NSArray  *courseLists = data[@"courseList"];
           NSArray *teacherLists = data[@"teacherList"];
            
           NSMutableArray *courseList = [NSMutableArray array];
           NSMutableArray * teacherList = [NSMutableArray array];
        
           [courseLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               NSDictionary *dict = (NSDictionary *)obj;
               courseRecommedModel *model = [[courseRecommedModel alloc] initWithDataDic:dict];
               [courseList addObject:model];
            }];
           [teacherLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               NSDictionary *dict = (NSDictionary *)obj;
              if(idx >= 3){
                  *stop = YES;
                   return ;
              }
              teacherRecommedModel *model = [[teacherRecommedModel alloc] initWithDataDic:dict];
              [teacherList addObject:model];
           }];
            self.courseList = courseList;
            self.teacherList = teacherList;
            [self initBannerListView];
            [self initTeacherView];
            [self initCourseRecommed];
        }
    }];
}
-(void)initNavigationBarButton{
    //设置首页导航栏logo图像
      NSLog(@"number===%ld",_teacherList.count);
    UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(homeNotice) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(searchEvent) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem, settingBtnItem];

}
-(void)initHomeView_Head{
    bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, P_Width, p_hight)];
    bigScrollView.showsVerticalScrollIndicator = NO;
    bigScrollView.contentSize = CGSizeMake(P_Width, 740);
    bigScrollView.backgroundColor = [UIColor whiteColor];
    bigScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDate)];
    [self.view addSubview:bigScrollView];

    //#pragma mark 加载课程视图
    bottonSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 440, P_Width, 185)];
    bottonSrollView.pagingEnabled = YES;
    bottonSrollView.showsHorizontalScrollIndicator = NO;
    [bigScrollView addSubview:bottonSrollView];
   
    __weak  typeof(self) weakself = self;
    _followBlock = ^(teacherRecommedModel *model){
        [weakself followwithModel:model];
    };
}
-(void)initTeacherView{
    _teachTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 165, P_Width-10, 275)];
    _teachTable.scrollEnabled = NO;
    [_teachTable registerNib:[UINib nibWithNibName:@"homeTeacherTable" bundle:nil] forCellReuseIdentifier:@"homeTeacherTable"];
    _teachTable.backgroundColor = [UIColor whiteColor];
    _teachTable.delegate = self;
    _teachTable.dataSource =self;
    _teachTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bigScrollView addSubview:_teachTable];
}
#pragma mark 加载头部广告栏内容
-(void)initBannerListView{
    NSArray *views = [smallScrollView subviews];
    for (UIView *view in views ) {
        [view removeFromSuperview];
    }
    smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 165)];
    smallScrollView.showsHorizontalScrollIndicator = NO;
    smallScrollView.showsVerticalScrollIndicator = NO;
    smallScrollView.contentSize = CGSizeMake(P_Width*self.imgURL.count, 165);
    smallScrollView.pagingEnabled = YES;
    smallScrollView.delegate = self;
    smallScrollView.tag = 100;
    smallScrollView.backgroundColor = [UIColor whiteColor];
    [bigScrollView addSubview:smallScrollView];
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(50, 150, P_Width-100, 0)];
    pageControl.numberOfPages = self.imgURL.count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = bg_color;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [bigScrollView addSubview:pageControl];

    //添加首页滚动图片
    for(int i=0;i<self.imgURL.count;i++){
        imageViewTop=[[UIImageView alloc]initWithFrame:CGRectMake(i*P_Width+10, 10, P_Width-20, 165)];
        imageViewTop.userInteractionEnabled = YES;
        imageViewTop.tag = i;
        imageViewTop.clipsToBounds = YES;
        imageViewTop.layer.cornerRadius = 9;
        [imageViewTop setImageWithURL:self.imgURL[i]];
        [smallScrollView addSubview:imageViewTop];
        
        //为smallscrollview添加手势
        UITapGestureRecognizer *singTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerDetail:)];
        singTap.numberOfTapsRequired = 1;
        singTap.numberOfTouchesRequired = 1;
        imageViewTop.userInteractionEnabled = YES;
        [imageViewTop addGestureRecognizer:singTap];
    }
  timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}
-(void)searchEvent{
    SearchViewController *search =[[SearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self setModalTransitionStyle: UIModalTransitionStyleCoverVertical];
    [self.navigationController pushViewController:search animated:YES];
   
}
-(void)homeNotice{
    UIBarButtonItem *bacBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = bacBtn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    HomeNoticeViewController *homeNotice =[[HomeNoticeViewController alloc] init];
    homeNotice.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeNotice animated:YES];
}
#pragma mark tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _teacherList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    homeTeacherTable *cell = [_teachTable dequeueReusableCellWithIdentifier:@"homeTeacherTable" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    teacherRecommedModel *model = _teacherList[indexPath.row];
    cell.model = model;
    cell.followBlock = ^(teacherRecommedModel *model){
        if (_followBlock) {
            _followBlock(model);
        }
    };
    return cell;
}
//设置头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"名医推荐";
}
//设置头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"精品课程";
}
//设置尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  65;
}
//设置头视图高度
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 40)];
        UIImageView *teacherImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 20, 20)];
        teacherImg.image = [UIImage imageNamed:@"home_teacher"];
        [headView addSubview:teacherImg];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 120, 10)];
        titleLabel.text = @"名医推荐";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [headView addSubview:titleLabel];
        return headView;
    }else
        return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, P_Width, 40)];
        UIImageView *teacherImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 20, 20)];
        teacherImg.image = [UIImage imageNamed:@"home_course"];
        [headView addSubview:teacherImg];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 120, 10)];
        titleLabel.text = @"精品课程";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [headView addSubview:titleLabel];
        return headView;
    }else
        return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    teacherRecommedModel *model = _teacherList[indexPath.row];
    teacherDetailViewController *vc = [[teacherDetailViewController alloc] init];
    vc.teacherId = model.teacherId;
    vc.teacherUserId = model.userId;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];    
}
#pragma mark 设置scrollview自动跳转
-(void)scrollToNextPage{
    long int pageNum = pageControl.currentPage;
    CGSize viewSize = smallScrollView.frame.size;
    CGRect rect = CGRectMake((pageNum+1)*viewSize.width, 0, viewSize.width, viewSize.height);
    [smallScrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum == self.imgURL.count) {
        CGRect newRect = CGRectMake(0*viewSize.width, 0, viewSize.width, viewSize.height);
        [smallScrollView scrollRectToVisible:newRect animated:NO];
    }
}

//scrollView的代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        int pageNum=scrollView.contentOffset.x/scrollView.frame.size.width;
        pageControl.currentPage=pageNum;
    }
}

#pragma mark 首页推荐课程
-(void)initCourseRecommed{
    NSArray *views = [bottonSrollView subviews];
    for(UIView *view in  views){
        [view removeFromSuperview];
    }
    bottonSrollView.contentSize = CGSizeMake(_courseList.count*135, 185);
    for (int i=0; i<_courseList.count;i++) {

       _models = _courseList[i];
        homeClassView = [[UIView alloc] initWithFrame:CGRectMake(i*125+15, 10, 110, 180)];
        homeClassView.tag = i;
        NSLog(@"iii===%ld",homeClassView.tag);
        [bottonSrollView addSubview:homeClassView];
        
        homeClassView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [homeClassView addGestureRecognizer:tap];
        
        classImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*0, 0, 110, 145)];
        classImage.clipsToBounds = YES;
        classImage.layer.cornerRadius = 5;
        NSString *strImg = [NSString stringWithFormat:@"%@",_models.icon];
        NSString *strClassImg = [NSString stringWithFormat:@"%@%@",IMG_URL,strImg];
        NSURL *classUrl = [NSURL URLWithString:strClassImg];
        [classImage setImageWithURL:classUrl];
        [homeClassView addSubview:classImage];
        //演员真实名字￥
        onImage = [[UIView alloc] initWithFrame:CGRectMake(i*0, 105, 110, 40)];
        onImage.backgroundColor = dark_viewColor;
        onImage.clipsToBounds = YES;
        onImage.layer.cornerRadius = 5;
        [homeClassView addSubview:onImage];
        
        className = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 110, 30)];
        className.text = _models.name;
        className.textColor = [UIColor whiteColor];
        className.font = [UIFont systemFontOfSize:12];
        className.numberOfLines = 0;
        className.lineBreakMode = 0;
        [onImage addSubview:className];
        
        nowPay=[[UILabel alloc]initWithFrame:CGRectMake(i*0, 145, 55, 30)];
        NSString *payNow = [NSString stringWithFormat:@"￥%@",_models.presentPrice];
        nowPay.text= payNow;
        nowPay.textColor=[UIColor blackColor];
        nowPay.font=[UIFont boldSystemFontOfSize:12];
        
        oldPay = [[UILabel alloc] initWithFrame:CGRectMake(i*0+56, 145, 55, 30)];
        NSString *oldpay = [NSString stringWithFormat:@"￥%@",_models.orignPrice];
        oldPay.text = oldpay;
        oldPay.font = [UIFont systemFontOfSize:11];
        oldPay.textColor = [UIColor lightGrayColor];
        NSDictionary *attriteDict = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribteStr = [[NSMutableAttributedString alloc] initWithString:oldpay attributes:attriteDict];
        oldPay.attributedText = attribteStr;
        [homeClassView addSubview:oldPay];
        
        [homeClassView addSubview:nowPay];
        [bigScrollView addSubview:bottonSrollView];
    }    
}
-(void)tap:(UITapGestureRecognizer *)gr{
    homeClassView = (UIView *)gr.view;
    _models = _courseList[homeClassView.tag];
    classDetailViewController *vc = [[classDetailViewController alloc]init];
    vc.courseId = _models.courseId;
    vc.courseRecommendModel = _models;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 广告栏详情
-(void)bannerDetail:(UITapGestureRecognizer *)gr{
    imageViewTop = (UIImageView *)gr.view;
    bannerDetailViewController *banDetail = [[bannerDetailViewController alloc] init];
    banDetail.linkStr = self.linkArray[imageViewTop.tag];
    banDetail.hidesBottomBarWhenPushed = YES;
    banDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:banDetail animated:YES];
}

#pragma mark 关注事件
-(void)followEvent{
    if (_followBlock) {
        _followBlock(_model);
    }
}
-(void)followwithModel:(teacherRecommedModel *)model
{   _model = model;
    UserModel *usermodel = [UserModel sharedInstance];
    NSDictionary *dict =@{@"userId":[NSString stringIsNull:usermodel.userId],@"teacherId":[NSString stringIsNull:model.teacherId]};
    NSLog(@"dict===%@",dict);
    NSString *title;
    if ([model.attendFlag integerValue] == 0) {
        title = @"关注";
    }else{
        title = @"取消关注";
    }
    ([MBProgressHUD showHUDAddedTo:self.view animated:YES]).labelText = [NSString stringWithFormat:@"%@中...",title];
    
    
    [NetService requestURL:@"/school/api/user/followTeacher" httpMethod:@"POST" params:dict completion:^(id result, NSError *error) {
        NSString *resultCode = result[@"resultCode"];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"data===%@",result);
        if ([resultCode isEqualToString:@"0"]) {

            if ([model.attendFlag integerValue]==0) {
                
                model.attendFlag = @1;
            }else{
                model.attendFlag = @0;
            }
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@成功~",title] toView:self.view];
            
            [self.teachTable reloadData];

        }else{
            
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@失败~",title] toView:self.view];
        }
}];

}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
