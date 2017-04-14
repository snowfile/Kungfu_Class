//
//  SignUpViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 24/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface SignUpViewController : BaseNaviViewController

@property(nonatomic,copy)NSString *courseId;
//总价
@property(nonatomic,copy)NSString *money;

@property(nonatomic,copy)NSString *price;
//数量
@property(nonatomic,copy)NSString *num;

//标题
@property(nonatomic,copy)NSString *courseTitle;

@property(nonatomic,copy)NSString *teacherName;
//上课时间
@property(nonatomic,copy)NSString *courseTime;

//课程图片url
@property(nonatomic,copy)NSString *courseImageUrl;

@property (weak, nonatomic) IBOutlet UIView *bacView;
@property (weak, nonatomic) IBOutlet UIImageView *courseImg;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseNum;
@property (weak, nonatomic) IBOutlet UILabel *totalPay;
@property (weak, nonatomic) IBOutlet UILabel *shouldPay;
@property (weak, nonatomic) IBOutlet UIButton *weiBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;

@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLab;

@end
