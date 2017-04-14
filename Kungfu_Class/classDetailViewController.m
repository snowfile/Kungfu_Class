//
//  classDetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 1/23/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "classDetailViewController.h"
#import "BaseViewController.h"
#import "CourseBaseView.h"
#import "CourseBriefView.h"
#import "TeacherIntroView.h"
#import "CourseArrangementView.h"
#import "teacherDetailViewController.h"
#import "SignUpViewController.h"
#import "PayAttentionView.h"
#import "SignUpView.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+frame.h"
#import "iToast.h"




@interface classDetailViewController ()
@property(nonatomic,strong)UIScrollView *scrollview;
//头部图片
@property(nonatomic,weak)UIImageView *headImageView;
//标题
@property(nonatomic,weak)UILabel *titleLabel;
//课程基本信息
@property(nonatomic,weak)CourseBaseView *courseBaseView;
//课程简介
@property(nonatomic,weak)CourseBriefView *briefView;
//讲师简介
@property(nonatomic,weak)TeacherIntroView *teacherIntroView;
//课程安排
@property(nonatomic,weak)CourseArrangementView *courseArrangeView;
//注意事项
@property(nonatomic,weak)PayAttentionView *attentionView;
//立即报名
@property(nonatomic,weak)SignUpView *signupView;
@end

@implementation classDetailViewController{
    NSString *teacherId;
    NSString *teacherUserId;
    NSNumber *isBooked;
    NSString *price;
    NSString *courseName;
    NSString *courseImgUrl;
    
    NSString *clickStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"课程详情";
    [self initUI];
    [self loadClassData];
}
-(void)loadClassData{
    UserModel *usermodel = [UserModel sharedInstance];
    NSDictionary *dict = @{@"coursesId":[NSString stringIsNull:_courseId],@"userId":usermodel.userId};
    [NetService requestURL:@"school/api/courses/info" httpMethod:@"GET" params:dict completion:^(id result,NSError *error){
        NSLog(@"resuiiiiii==%@",result);
        NSString *resultCode = result[@"resultCode"];
        [_scrollview.mj_header endRefreshing];
        if ([resultCode isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            NSArray *chapterlist = data[@"chaptersList"];
            NSDictionary *coursesInfo = data[@"coursesInfo"];
            
            NSString *detailIconUrl = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:coursesInfo[@"detailIcon"]]];
            [_headImageView setImageWithURL:[NSURL URLWithString:detailIconUrl] placeholderImage:[UIImage imageNamed:@"课程详情灰色"]];
            _courseBaseView.nameLab.text = coursesInfo[@"teacherName"];
            _courseBaseView.timeLab.text = [NSString stringWithFormat:@"%@ 至 %@",coursesInfo[@"startTime"],coursesInfo[@"endTime"]];
            _courseBaseView.placeLab.text =  [NSString stringWithFormat:@"上课地点: %@%@%@%@",coursesInfo[@"province"],coursesInfo[@"city"],coursesInfo[@"area"],coursesInfo[@"address"]];;
            isBooked =coursesInfo[@"isBooked"];
            
            [_courseBaseView setOriginalPriceStr:[NSString stringWithFormat:@"￥%0.2f",[coursesInfo[@"originalPrice"] floatValue ]]];            _courseBaseView.nowprice.text = [NSString stringWithFormat:@"￥%0.2f",[coursesInfo[@"presentPrice"] floatValue]];
            
            _briefView.contentStr = coursesInfo[@"description"];
            
            _teacherIntroView.contentStr = coursesInfo[@"teacherDesc"];
            _teacherIntroView.teacherNameLab.text = coursesInfo[@"teacherName"];
            NSString *position = [NSString stringWithFormat:@"%@/%@",coursesInfo[@"duties"],coursesInfo[@"teachDuties"]];
            _teacherIntroView.positionLab.text = position;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:coursesInfo[@"teacherIcon"]]];
            courseImgUrl = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:coursesInfo[@"listIcon"]]];
            
            [_teacherIntroView.teacherImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"people"]];
            teacherId = coursesInfo[@"teacherId"];
            teacherUserId = coursesInfo[@"teacherUserId"];
            
            _courseArrangeView.nameLab.text = [NSString stringWithFormat:@"课程名称: %@",coursesInfo[@"coursesName"]];
            
            courseName = coursesInfo[@"coursesName"];
            
            _courseArrangeView.sponsorLab.text = [NSString stringWithFormat:@"主办方: %@",coursesInfo[@"sponsor"]];
            
            
            _courseArrangeView.numLab.text = [NSString stringWithFormat:@"报名人数: %@",coursesInfo[@"limitCount"]];
            
            _courseArrangeView.timeLab.text = [NSString stringWithFormat:@"上课时间: %@至%@",coursesInfo[@"startTime"],coursesInfo[@"endTime"]];
            _courseArrangeView.addressLab.text = [NSString stringWithFormat:@"上课地点: %@%@%@%@",coursesInfo[@"province"],coursesInfo[@"city"],coursesInfo[@"area"],coursesInfo[@"address"]];
            
            _courseArrangeView.dataMarray = [NSMutableArray arrayWithArray:chapterlist];
            if ([isBooked intValue]!= 0) {
                [_courseBaseView.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            }else{
                [_courseBaseView.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
            }
            _signupView.priceLab.text = [NSString stringWithFormat:@"￥%@",coursesInfo[@"presentPrice"]];
            _signupView.money = [coursesInfo[@"presentPrice"] floatValue];
            price = coursesInfo[@"presentPrice"];
            if ([coursesInfo[@"status"] intValue] != 1) {
                _signupView.SignUpBtn.backgroundColor = [UIColor lightGrayColor];
                _signupView.SignUpBtn.userInteractionEnabled = NO;
                if ([coursesInfo[@"status"] intValue]==0) {
                    [_signupView.SignUpBtn setTitle:@"未上架" forState:UIControlStateNormal];
                }if ([coursesInfo[@"status"] intValue] == 3) {
                    [_signupView.SignUpBtn setTitle:@"报名结束" forState:UIControlStateNormal];
                }if ([coursesInfo[@"status"] intValue] == 4) {
                    [_signupView.SignUpBtn setTitle:@" 已下架" forState:UIControlStateNormal];
                }
            }else{
            
                
                _signupView.SignUpBtn.backgroundColor = COLOR;
                
                _signupView.SignUpBtn.userInteractionEnabled = YES;
                [_signupView.SignUpBtn setTitle:@"立即报名" forState:UIControlStateNormal];
            }
        }
        else{
            [MBProgressHUD showError:@"加载失败" toView:self.view];
        }
    }];
_attentionView.contentStr = @"1.开课前一天的下午或培训当天8:30前报到（以短信通知为准。\n2.安排中午便餐，其它食宿自理；如需预定酒店，需要预付第一天的房费，由于个人原因不能入住，所有损失个人承担。\n3.按付款先后顺序安排座位。\n4.学习中允许拍照，禁止摄像、录音。\n5. 禁止正式学员携带其他人进入会场。\n6. 因个人原因无法参加本次培训班，不可退费。";

}
-(void)initUI{
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    _scrollview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadClassData)];
    [self.view addSubview:_scrollview];
    UIView *inImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 130)];
    inImage.backgroundColor = [UIColor whiteColor];
    [_scrollview addSubview:inImage];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, P_Width-20, 115)];
    imageview.clipsToBounds = YES;
    imageview.layer.cornerRadius = 9;
    imageview.image = [UIImage imageNamed:@"课程详情灰色"];
    _headImageView = imageview;
    [inImage addSubview:imageview];

    //课程基本信息
    CourseBaseView *cview = [[[NSBundle mainBundle]loadNibNamed:@"CourseBaseView" owner:nil options:nil] firstObject];
    cview.frame = CGRectMake(0, CGRectGetMaxY(imageview.frame), P_Width, 120);
    _courseBaseView = cview;
    __weak typeof(self) weakself = self;
    _courseBaseView.storeBlock = ^(NSString *string){
        [weakself store];
    };
    [_scrollview addSubview:_courseBaseView];


//课程简介
    CourseBriefView *cbView = [[[NSBundle mainBundle]loadNibNamed:@"CourseBriefView" owner:nil options:nil] firstObject];
    cbView.frame = CGRectMake(0, CGRectGetMaxY(_courseBaseView.frame)+5, P_Width, 220);
    _briefView = cbView;
    [_scrollview addSubview:_briefView];
    _briefView.changeframe = ^(CGFloat h){
        _briefView.height = h;
        [weakself changeFrame];
    
    };
    //讲师简介
    TeacherIntroView *tView = [[[NSBundle mainBundle]loadNibNamed:@"TeacherIntroView" owner:nil options:nil]firstObject];
    tView.frame = CGRectMake(0, CGRectGetMaxY(cbView.frame),P_Width, 220);
    _teacherIntroView = tView;
    [_scrollview addSubview:_teacherIntroView];
    _teacherIntroView.changeFrame = ^(CGFloat h){
        _teacherIntroView.height = h;
        [weakself changeFrame];
    
    };
    _teacherIntroView.lookLectureBlock = ^(NSString *string){
        [weakself lookLectureAbout];
    };
    //课程安排
    CourseArrangementView *caView = [[[NSBundle mainBundle]loadNibNamed:@"CourseArrangementView" owner:nil options:nil] firstObject];
    caView.frame = CGRectMake(0, CGRectGetMaxY(tView.frame), P_Width, 300);
    _courseArrangeView = caView;
    _courseArrangeView.changeFrame = ^(CGFloat h){
        _courseArrangeView.height = h;
        [weakself changeFrame];
    };
    [_scrollview addSubview:_courseArrangeView];
    
    //注意事项
    PayAttentionView *pView = [[[NSBundle mainBundle]loadNibNamed:@"PayAttentionView" owner:nil options:nil] firstObject];
    pView.frame = CGRectMake(0, 0, P_Width, 220);
    pView.height = 220;
    _attentionView = pView;
    [_scrollview addSubview:_attentionView];
    
    _attentionView.chanageFrme = ^(CGFloat h){
        _attentionView.height = h;
        [weakself changeFrame];
    };
    //立即报名
    SignUpView *signView= [[[NSBundle mainBundle] loadNibNamed:@"SignUpView" owner:nil options:nil] firstObject];
    signView.frame = CGRectMake(0, p_hight-164, P_Width, 100);
    signView.height = 100;
    _signupView = signView;
    [self.view addSubview:_signupView];
    _signupView.shopingBlock = ^(NSString *money){
        [weakself shopping];
    };
}
-(void)store{
    UserModel *usermodel = [UserModel sharedInstance];
    NSDictionary *dict = @{@"coursesId":_courseId,@"userId":[NSString stringIsNull:usermodel.userId]};
    NSLog(@"3333===%@",dict);
    NSString *currentStr = _courseBaseView.collectBtn.currentTitle;
    [NetService requestURL:@"school/api/user/collectCourses" httpMethod:@"POST" params:dict completion:^(id result,NSError *error){
        NSLog(@"结构===%@",result);
        NSString *resultCode = result[@"resultCode"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([resultCode isEqualToString:@"0"]) {
            if ([currentStr isEqualToString:@"收藏"]) {
                [_courseBaseView.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                _courseBaseView.collectBtn.backgroundColor = [UIColor whiteColor];
                [_courseBaseView.collectBtn setTitleColor:UIColoerFromRGB(0xfe8729) forState:UIControlStateNormal];
               _courseBaseView.collectBtn.layer.borderColor = UIColoerFromRGB(0xfe8729).CGColor;
                [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
            }else{
                [_courseBaseView.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [_courseBaseView.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _courseBaseView.collectBtn.layer.cornerRadius = 4;
                _courseBaseView.collectBtn.clipsToBounds = YES;
                _courseBaseView.collectBtn.backgroundColor =UIColoerFromRGB(0xfe8729);
                [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CancelStore" object:nil];
            }
          
        }else{
        
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@失败",currentStr] toView:self.view];
        }

    }];
}
#pragma mark-----查看名师详情
-(void)lookLectureAbout{
    teacherDetailViewController *detailView = [[teacherDetailViewController alloc] init];
    detailView.teacherId = teacherId;
    detailView.teacherUserId = teacherUserId;
    [self.navigationController pushViewController:detailView animated:YES];
}
#pragma mark ---立即报名
-(void)shopping{
    SignUpViewController *signUp = [[SignUpViewController alloc] init];
    signUp.courseId = _courseId;
    signUp.money = _signupView.priceLab.text;
    signUp.num = _signupView.numLab.text;
    signUp.price = price;
    signUp.courseTime = _courseArrangeView.timeLab.text;
    signUp.teacherName = [NSString stringWithFormat:@"主讲老师: %@",_courseBaseView.nameLab.text];
    signUp.courseImageUrl = courseImgUrl;
    signUp.courseTitle =courseName;
    
    [self.navigationController pushViewController:signUp animated:YES];
}
#pragma mark ----scrollview的滚动范围
-(void)changeFrame{
    [UIView animateWithDuration:0.1 animations:^{
        _teacherIntroView.y = _briefView.y+_briefView.height+5;
        _courseArrangeView.y = _teacherIntroView.y + _teacherIntroView.height+5;
        _attentionView.y  = _courseArrangeView.y + _courseArrangeView.height+5;
        _scrollview.contentSize = CGSizeMake(Screen_Width, _attentionView.y+_attentionView.height+125);
    }];
}
 //显示itoast
 -(void)showToastWithText:(NSString *)text{
     iToast *toast = [iToast makeText:text];
     toast.theSettings.gravity = iToastGravityCustom;
     [toast setPostion:CGPointMake(Screen_Width/2, Screen_Height/2)];
     [toast show];
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
