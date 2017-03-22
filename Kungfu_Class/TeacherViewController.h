//
//  TeacherViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 12/14/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
@class teacherModels;

typedef void (^LookTeacherDetailBlock)(teacherModels *model);

@interface TeacherViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)LookTeacherDetailBlock lookTeacherDetailBlock;
@end
