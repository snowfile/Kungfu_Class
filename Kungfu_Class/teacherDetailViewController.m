//
//  teacherDetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 06/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "teacherDetailViewController.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"


@interface teacherDetailViewController ()
@property(nonatomic,copy)NSString *userId;

@end

@implementation teacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"名师详情";
    
    self.profileImg.layer.cornerRadius = 35;
    self.profileImg.clipsToBounds = YES;
    
    self.followBtn.clipsToBounds = YES;
   
    self.descView.scrollEnabled = YES;
    self.descView.userInteractionEnabled = YES;
    [self initTeacherDetail];

}
-(void)initTeacherDetail{
    self.followBtn.layer.cornerRadius = 5.5;
    UserModel *usermodel =  [UserModel sharedInstance];
    NSDictionary *dict = @{@"userId":usermodel.userId, @"teacherId":self.teacherId,@"teacherUserId":self.teacherUserId};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetService requestURL:@"/school/api/teacher/info" httpMethod:@"GET" params:dict completion:^(id result,NSError *error){
        
        NSString *resultCode = result[@"resultCode"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([resultCode isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            NSDictionary *teacherInfo = data[@"teacherInfo"];
            
            NSDictionary *stat = data[@"stat"];
            self.classNum.text = [NSString stringWithFormat:@"%@",stat[@"courseCnt"]];
            self.fansNum.text = [NSString stringWithFormat:@"%@",stat[@"attendCnt"]];
            
            self.nameLab.text = teacherInfo[@"teacherName"];
            
            NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:teacherInfo[@"icon"]]];
            NSURL *imgURL= [NSURL URLWithString:url];
            [self.profileImg setImageWithURL:imgURL];
            
            self.positionLab.text = [NSString stringWithFormat:@"%@ %@",teacherInfo[@"duties"],teacherInfo[@"teachDuties"]];
            
            self.hosipital.text = teacherInfo[@"hospitalName"];
            self.classLab.text = teacherInfo[@"departmentName"];
            self.descView.userInteractionEnabled = NO;
            self.descView.text = teacherInfo[@"description"];
            if ([teacherInfo[@"attendFlag"] intValue] == 0) {
                [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
            }else{
                [_followBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            }
        }else{
            [MBProgressHUD showError:@"请求数据失败" toView:self.view];
        }
    }];

}
- (IBAction)followBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.followBtn.layer.cornerRadius = 5.5;
    UserModel *usermodel =  [UserModel sharedInstance];
    NSString *currentStr = btn.currentTitle;
    NSDictionary *dict = @{@"userId":[NSString stringIsNull:usermodel.userId],@"teacherId":[NSString stringIsNull:_teacherId]};
    NSLog(@"dict===%@",dict);
    
    ([MBProgressHUD showHUDAddedTo:self.view animated:YES]).labelText = [NSString stringWithFormat:@"%@中...",currentStr] ;
    [NetService requestURL:@"/school/api/user/followTeacher" httpMethod:@"POST" params:dict completion:^(id result,NSError *error){
        NSLog(@"follloe===%@",result);
        NSString *resultCode = result[@"resultCode"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([resultCode isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@成功",currentStr] toView:self.view];
            if ([currentStr isEqualToString:@"关注"]) {
                [_followBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                _fansNum.text =[NSString stringWithFormat:@"%d",[_fansNum.text intValue]+1];
            }else{
                [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
                _fansNum.text = [NSString stringWithFormat:@"%d",[_fansNum.text intValue]-1];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionSuccess" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionSuccessInMine" object:nil];
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@失败",currentStr] toView:self.view];
        }
    }];
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
