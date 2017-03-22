//
//  teacherDetailViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 06/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface teacherDetailViewController : BaseNaviViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UILabel *classNum;
@property (weak, nonatomic) IBOutlet UILabel *fansNum;
@property (weak, nonatomic) IBOutlet UILabel *hosipital;


@property (weak, nonatomic) IBOutlet UILabel *classLab;
@property (weak, nonatomic) IBOutlet UITextView *descView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;


@property(nonatomic,copy)NSString *teacherId;
@property(nonatomic,copy)NSString *teacherUserId;
@end
