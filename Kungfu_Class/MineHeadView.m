//
//  MineHeadView.m
//  Kungfu_Class
//
//  Created by 静静 on 15/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark -- 创建视图
-(void)createUI{
    float vh = self.height;
    
    _peopleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (vh-70)/2, 70, 70)] ;
    _peopleImageView.clipsToBounds = YES;
    _peopleImageView.image = [UIImage imageNamed:@"people"];
    _peopleImageView.layer.cornerRadius = 35;
    _peopleImageView.backgroundColor = [UIColor whiteColor];
    _peopleImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [_peopleImageView addGestureRecognizer:imageTap];
    [self addSubview:_peopleImageView];
    
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame)+15, CGRectGetMaxY(_peopleImageView.frame)-17.5, 100, 35)];
    [_loginBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_loginBtn addTarget:self action:@selector(loginOrsign:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame)+15, CGRectGetMidY(_peopleImageView.frame)-10, 100, 21)];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTap:)];
    [_nameLabel addGestureRecognizer:nameTap];
    
    [self addSubview:_nameLabel];
    
    //分割线
    UILabel *lineOne = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/3-1, vh-40, 1, 15)];
    lineOne.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineOne];
    
    UILabel *lineTwo = [[UILabel alloc] initWithFrame:CGRectMake(2*Screen_Width/3, vh-40, 1, 15)];
    lineTwo.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineTwo];
    
    //我的关注
    UILabel *focuslbl = [[UILabel alloc] init];
    focuslbl.textAlignment = NSTextAlignmentCenter;
    focuslbl.font = [UIFont systemFontOfSize:14];
    focuslbl.x = (Screen_Width/3-80)/2;
    focuslbl.y = lineOne.y-15;
    focuslbl.width = 80;
    focuslbl.height = 21;
    focuslbl.text = @"我的关注";
    focuslbl.textColor = [UIColor whiteColor];
    [self addSubview:focuslbl];
    
    _followLab= [[UILabel alloc] init];
    _followLab.textAlignment = NSTextAlignmentCenter;
    _followLab.font = [UIFont systemFontOfSize:20];
    _followLab.x = (Screen_Width/3-80)/2;
    _followLab.y = focuslbl.y+22;
    _followLab.width = 80;
    _followLab.height = 21;
    _followLab.text = @"0";
    _followLab.textColor = [UIColor whiteColor];
    [self addSubview:_followLab];
    
    _followLab.userInteractionEnabled = YES;
    focuslbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *focustap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusTap:)];
    
    UITapGestureRecognizer *focustap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusTap:)];
    
    [_followLab addGestureRecognizer:focustap1];
    [focuslbl addGestureRecognizer:focustap2];

    
    //参与课程
    UILabel *classlbl = [[UILabel alloc] init];
    classlbl.textAlignment = NSTextAlignmentCenter;
    classlbl.font = [UIFont systemFontOfSize:14];
    classlbl.x = self.center.x-40;
    classlbl.y = lineOne.y-15;
    classlbl.width = 80;
    classlbl.height = 21;
    classlbl.text = @"参与课程";
    classlbl.textColor = [UIColor whiteColor];
    [self addSubview:classlbl];
    
    _classLab = [[UILabel alloc] init];
    _classLab .textAlignment = NSTextAlignmentCenter;
    _classLab.font = [UIFont systemFontOfSize:20];
    _classLab.x = self.center.x-40;
    _classLab.y = classlbl.y+22;
    _classLab.width = 80;
    _classLab.height = 21;
    _classLab.text = @"0";
    _classLab.textColor = [UIColor whiteColor];
    [self addSubview:_classLab ];
    
    _classLab .userInteractionEnabled = YES;
    classlbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *classtap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(classTap:)];
    
    UITapGestureRecognizer *classtap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(classTap:)];
    
    [_classLab  addGestureRecognizer:classtap1];
    [classlbl addGestureRecognizer:classtap2];
    
    
    //我的积分
    
    UILabel *inegralbl = [[UILabel alloc] init];
    inegralbl.textAlignment = NSTextAlignmentCenter;
    inegralbl.font = [UIFont systemFontOfSize:14];
    inegralbl.x = (Screen_Width/3-80)/2+2*Screen_Width/3;
    inegralbl.userInteractionEnabled = YES;
    inegralbl.y = lineOne.y-15;
    inegralbl.width = 80;
    inegralbl.height = 21;
    inegralbl.text = @"我的积分";
    inegralbl.textColor = [UIColor whiteColor];
    [self addSubview:inegralbl];
    
    _intergralLab = [[UILabel alloc] init];
    _intergralLab.textAlignment = NSTextAlignmentCenter;
    _intergralLab.font = [UIFont systemFontOfSize:20];
    _intergralLab.x = (Screen_Width/3-80)/2+2*Screen_Width/3;
    _intergralLab.y = inegralbl.y+22;
    _intergralLab.width = 80;
    _intergralLab.height = 21;
    _intergralLab.text = @"0";
    _intergralLab.userInteractionEnabled = YES;
    _intergralLab.textColor = [UIColor whiteColor];
    [self addSubview:_intergralLab];
    
   _intergralLab.userInteractionEnabled = YES;
    inegralbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *inegraltap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(integralTap:)];
    
    UITapGestureRecognizer *inegraltap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(integralTap:)];
    
    [_intergralLab addGestureRecognizer:inegraltap1];
    [inegralbl addGestureRecognizer:inegraltap2];
    
    
    _intergralLab.text = @"";
    _followLab.text = @"";
    _intergralLab.text = @"";

    
}
#pragma mark -我的关注
-(void)focusTap:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"我的关注");
    }
}

#pragma mark -参与课程
-(void)classTap:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"参与课程");
    }
}
-(void)integralTap:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"我的积分");
    }
}
#pragma mark --个人信息
-(void)imageTap:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"个人信息");
    }
}
-(void)nameTap:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"个人信息");
    }
}
#pragma mark - 登录或注册
-(void)loginOrsign:(UITapGestureRecognizer *)gr{
    if (_mineHeadBlock) {
        _mineHeadBlock(@"登录或注册");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
