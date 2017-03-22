//
//  schemeViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "schemeViewController.h"
#import "patientViewController.h"
#import "appointViewController.h"
#import "visitViewController.h"
#import "SwitchClinicVC.h"
#import "CreatClinicVC.h"

@interface schemeViewController (){
    UITableView *schemeTableView;;
    UIButton *appointBtn;
    UIButton *patientBtn;
    UIButton *visitBtn;
    NSArray *imgArray;
    NSArray *menuArray;
    JSDropmenuView *dropmenuView;
}
@end

@implementation schemeViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeScheme];
        self.title = @"看诊";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    imgArray = @[@"新增预约",@"新增回访",@"新增患者",@"新增预约"];
    menuArray =@[@{@"imageName":@"选择诊所",@"title":@"选择诊所"},@{@"imageName":@"创建诊所",@"title":@"创建诊所"}];
    self.view.backgroundColor = [UIColor lightTextColor];
    [self initSchemeView];
}
-(void)initSchemeView{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 200)];
    topView.backgroundColor =[ UIColor whiteColor];
    [self.view addSubview:topView];
    //患者管理
    patientBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, P_Width-16, 75)];
    [patientBtn setBackgroundImage:[UIImage imageNamed:@"患者管理"] forState:UIControlStateNormal];
      [patientBtn setBackgroundImage:[UIImage imageNamed:@"患者管理"] forState:UIControlStateHighlighted];
    [patientBtn addTarget:self action:@selector(patientManager) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:patientBtn];
    
  //预约
    appointBtn =[[ UIButton alloc] initWithFrame:CGRectMake(8, 85, (P_Width-24)/2, 75)];
    [appointBtn setBackgroundImage:[UIImage imageNamed:@"预约管理"] forState:UIControlStateNormal];
        [appointBtn setBackgroundImage:[UIImage imageNamed:@"预约管理"] forState:UIControlStateHighlighted];
    [appointBtn addTarget:self action:@selector(appointManager) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:appointBtn];
    
    //回访
    visitBtn = [[UIButton alloc] initWithFrame:CGRectMake((P_Width-24)/2+16, 85, (P_Width-24)/2, 75)];
    [visitBtn setBackgroundImage:[UIImage imageNamed:@"回访管理"] forState:UIControlStateNormal];
    [visitBtn setBackgroundImage:[UIImage imageNamed:@"回访管理"] forState:UIControlStateHighlighted];
    [visitBtn addTarget:self action:@selector(visitManager) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:visitBtn];
  
    UIView  *partView = [[UIView alloc] initWithFrame:CGRectMake(0, 163, P_Width, 35)];
    [self.view addSubview:partView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(8,4, 120, 30);
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"优惠券管理";
    [partView addSubview:label];
    
    
    UIImageView *arror = [[UIImageView alloc] initWithFrame:CGRectMake(P_Width-28, 12, 18,18)];
    arror.image =[ UIImage imageNamed:@"arror"];
    [partView addSubview:arror];
    
    
    
    schemeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 202, P_Width, p_hight-202)];
    schemeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    schemeTableView.delegate = self;
    schemeTableView.dataSource = self;
    schemeTableView.scrollEnabled = NO;
    [schemeTableView registerClass:[SchemeTableViewCell class] forCellReuseIdentifier:@"SchemeTableViewCell"];
    [self.view addSubview:schemeTableView];
    
    //初始化导航栏右上的按钮
    UIButton *moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreOperationEvent) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
#pragma mark tableView的代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        return @"最新消息";
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 40)];
        UIImageView *imageMessage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 25, 25)];
        imageMessage.image = [UIImage imageNamed:@"message"];
        [headView addSubview:imageMessage];
      
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 60, 25)];
        messageLabel.text = @"最新消息";
        messageLabel.font = [UIFont systemFontOfSize:12];
        [headView addSubview:messageLabel];
        return headView;
}
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
            return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemeTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [SchemeTableViewCell new];
    }
    cell.titleImage.image = [UIImage imageNamed:imgArray[indexPath.row]];
    cell.titleLabel.textColor = [UIColor blackColor];
    cell.titleLabel.font = [UIFont systemFontOfSize:12];
    cell.detailLabel.text = @"16-12-28,14点，武汉冠美口腔，洗牙";
    NSInteger row = indexPath.row;
    if (row == 0) {
        cell.titleLabel.text = @"预约消息";

    }else if (row == 1){
        cell.titleLabel.text = @"回访消息";

      
    }else if (row == 2){
        cell.titleLabel.text = @"新增患者";


    }else if (row == 3){
        cell.titleLabel.text = @"预约消息";

    }
  
    return cell;
    
}
//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
            return  50;
}
-(void)moreOperationEvent{
    if (!dropmenuView) {
        dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(P_Width-130,45, 120, 45*2+12)];
        dropmenuView.delegate = self;
    }
    [dropmenuView showViewInView:self.navigationController.view];
}
- (void)dropmenuView:(JSDropmenuView *)dropmenuView didSelectedRow:(NSInteger)index {
    
    if(index >= menuArray.count){
        return;
    }
    
    if (index == 0) {
        SwitchClinicVC *vc = [[SwitchClinicVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *bacBtn = [[UIBarButtonItem alloc] init];
        bacBtn.title = @" ";
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationItem.backBarButtonItem = bacBtn;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        CreatClinicVC *vc =[[CreatClinicVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(NSArray *)dropmenuDataSource{

    return menuArray;
}
//患者管理
-(void)patientManager{


    patientViewController *patient = [[patientViewController alloc] init];
    patient.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:patient animated:YES];
    
}
//预约管理
-(void)appointManager{

    appointViewController *appoint = [[appointViewController alloc] init];
    appoint.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:appoint animated:YES];
}
//回访管理
-(void)visitManager{
    visitViewController *visit = [[visitViewController alloc] init];
    visit.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:visit animated:YES];
}
//设定collectionView与四周边框距离(分别为：上，左，下，右)
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0,0,1,1);
//}
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
