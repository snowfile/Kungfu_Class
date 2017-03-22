//
//  TeacherIntroView.h
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Changeframe)(CGFloat h);

typedef void(^LookLectureBlock)(NSString *string);

@interface TeacherIntroView : UIView
@property(nonatomic,strong)LookLectureBlock  lookLectureBlock;
@property(nonatomic,strong)Changeframe  changeFrame;
@property (weak, nonatomic) IBOutlet UIImageView *teacherImg;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property(nonatomic,copy)NSString *contentStr;

@end
