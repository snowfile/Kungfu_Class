//
//  classViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "BaseViewController.h"
#import "TeacherViewController.h"
#import "classDetailViewController.h"
#import "BaseTabViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "NetService.h"
#import "ClassModel.h"

typedef void (^LookDetailBlock)(ClassModel *model);

@interface classViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)LookDetailBlock lookDetailBlock;
+(instancetype)shareInstance;
@end
