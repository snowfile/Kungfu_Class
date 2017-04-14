//
//  homeViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "BaseViewController.h"
#import "TeacherViewController.h"
#import "classViewController.h"
#import "TableCell.h"
@class teacherRecommedModel;
typedef void(^FollowBlock)(teacherRecommedModel *model);

@interface homeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)FollowBlock followBlock;
@property(nonatomic,strong)teacherRecommedModel *model;
@property(nonatomic,strong)courseRecommedModel *models;

@end
