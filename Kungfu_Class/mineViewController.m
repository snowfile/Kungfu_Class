//
//  mineViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "mineViewController.h"
#import "orderViewController.h"
#import "CouponsViewController.h"
#import "favoriteViewController.h"
#import "MessageViewController.h"
#import "inviteViewController.h"
#import "AdviceViewController.h"
#import "systemViewController.h"
#import "mineCentralViewController.h"
#import "UIStoryboard+KFMutipleStoryboards.h"

@interface mineViewController (){
    UIView *profileView;
    UIButton *profileImgBtn;
    UILabel *nameLabel;
    UILabel *positionLabel;
    UIButton *signinBtn;
    UILabel *numLabel;
    UICollectionView *meCollectionView;
    UITableView *meTableView;
    NSArray *meTabImgs_arr;
    NSArray *meTabName_arr;
    NSArray *threeBtnTittle_arr;    
}
@end

@implementation mineViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeMine];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    meTabName_arr = @[@"我的订单",@"我的优惠券",@"我的收藏",@"消息中心",@"邀请好友",@"意见反馈",@"系统设置"];
    meTabImgs_arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    threeBtnTittle_arr = @[@"我的关注",@"我的课程",@"我的积分"];
    [self initMeView];
}
-(void)initMeView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    imageView.image = [UIImage imageNamed:@"我的背景"];
    [self.view addSubview:imageView];
    
    meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight) style:UITableViewStylePlain];
    [meTableView registerNib:[UINib nibWithNibName:@"MeViewTableCell" bundle:nil] forCellReuseIdentifier:@"MeViewTableCell"];
    //将tableView无数据的cell线去掉
    meTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    meTableView.delegate = self;
    meTableView.dataSource = self;
    meTableView.backgroundColor = [UIColor clearColor];
     profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 200)];
    meTableView.tableHeaderView = profileView;
    meTableView.tableHeaderView.userInteractionEnabled = YES;
    [self.view addSubview:meTableView];
    [self initThreeBtn];
}
-(void)initThreeBtn{
    for (int i=1; i<3; i++) {
        UIView *partView = [[UIView alloc] initWithFrame:CGRectMake((P_Width/3)*i-0.5, 160, 1, 15)];
        partView.backgroundColor = [UIColor whiteColor];
        [profileView addSubview:partView];
    }
    
  for (int i=0; i<3;i++) {
      UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      meBtn.frame = CGRectMake((P_Width/3)*i+25, 145, P_Width/3-50, 25);
      [meBtn setTitle:threeBtnTittle_arr[i] forState:UIControlStateNormal];
      meBtn.titleLabel.font = [UIFont systemFontOfSize:12];
      [profileView addSubview:meBtn];

      numLabel = [[UILabel  alloc] initWithFrame:CGRectMake((P_Width/3)*i+30, 170, P_Width/3-60, 25)];
      numLabel.text = @"12";
      numLabel.textColor = [UIColor whiteColor];
      numLabel.textAlignment = NSTextAlignmentCenter;
      numLabel.font = [UIFont systemFontOfSize:12];
      [profileView addSubview:numLabel];
  }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
}
//去掉tableView中headerView吸附头部效果
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == meTableView) {
//        CGFloat sectionHeaderHeight = 200;
//        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y>= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        }
//    }
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
    profileView.backgroundColor = [UIColor clearColor];
    profileView.userInteractionEnabled = YES;
    profileImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, 60, 60)];
    profileImgBtn.layer.cornerRadius = 30;
    profileImgBtn.clipsToBounds = YES;
    [profileImgBtn setBackgroundImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
    [profileImgBtn addTarget:self action:@selector(imageProfileClick) forControlEvents:UIControlEventTouchUpInside];
    [profileView addSubview:profileImgBtn];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 58, 60, 30)];
    nameLabel.text = @"秦静";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [UIColor whiteColor];
    [profileView addSubview:nameLabel];
        
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        nameLabel.userInteractionEnabled = YES;
        [nameLabel addGestureRecognizer:singleTap];
    
    
    //signinBtn = [[UIButton alloc] initWithFrame:CGRectMake(P_Width-80, 88, 60, 26)];
    //[signinBtn setTitle:@"签到" forState:UIControlStateNormal];
    //signinBtn.backgroundColor = [UIColor lightTextColor];
   // [signinBtn.layer setBorderWidth:1];
   //[profileView addSubview:signinBtn];

    for (int i=1; i<3; i++) {
        UIView *partView = [[UIView alloc] initWithFrame:CGRectMake((P_Width/3)*i-0.5, 160, 1, 15)];
        partView.backgroundColor = [UIColor whiteColor];
        [profileView addSubview:partView];
    }
    for (int i=0; i<3;i++) {
        UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        meBtn.frame = CGRectMake((P_Width/3)*i+25, 145, P_Width/3-50, 25);
        [meBtn setTitle:threeBtnTittle_arr[i] forState:UIControlStateNormal];
        meBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [profileView addSubview:meBtn];
        
        numLabel = [[UILabel  alloc] initWithFrame:CGRectMake((P_Width/3)*i+30, 170, P_Width/3-60, 25)];
        numLabel.text = @"12";
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:12];
        [profileView addSubview:numLabel];
    }
    }
    return profileView;
}
#pragma mark tableview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeViewTableCell" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    //设置cell的右边样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *meTabImg = (UIImageView *)[cell viewWithTag:1];
    meTabImg.image = [UIImage imageNamed:meTabImgs_arr[indexPath.row]];
    [meTabImg sizeToFit];
    UILabel *meTabName = (UILabel *)[cell viewWithTag:2];
    meTabName.font = [UIFont systemFontOfSize:15];
    meTabName.textAlignment = NSTextAlignmentLeft;
    meTabName.text = meTabName_arr[indexPath.row];
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            orderViewController *order = [[orderViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:order];
            [navi setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 1:{
            CouponsViewController *coupons = [[CouponsViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:coupons];
            [navi setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:navi animated:YES completion:nil];
            
            break;
        }
        case 2:{
            favoriteViewController *favorte = [[favoriteViewController alloc] init];
            UINavigationController *navi =[[[UINavigationController alloc] init]initWithRootViewController:favorte];
            [navi setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 3:{
            MessageViewController *message =[[MessageViewController alloc] init];
            UINavigationController *navi =[[UINavigationController alloc] initWithRootViewController:message];
            [navi setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 4:{
            inviteViewController *invite = [[inviteViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:invite];
            [navi setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 5:{
            AdviceViewController *advice = [[AdviceViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:advice];
            navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 6:{
            systemViewController *system = [[systemViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:system];
            navi.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
           [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

-(void)imageProfileClick{
    mineCentralViewController *mineCentral = [[mineCentralViewController alloc] init];
    [self presentViewController:mineCentral animated:YES completion:nil];

}
-(void)singleTap{
    mineCentralViewController *mineCentral = [[mineCentralViewController alloc] init];
    //[self presentViewController:mineCentral animated:YES completion:nil];
    [self.navigationController pushViewController:mineCentral animated:YES];


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
