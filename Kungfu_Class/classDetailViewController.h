//
//  classDetailViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 1/23/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"
@class ClassModel;
@class courseRecommedModel;

@interface classDetailViewController : BaseNaviViewController

@property(nonatomic,strong)courseRecommedModel *courseRecommendModel;
@property(nonatomic,strong)ClassModel *classModel;
@property(nonatomic,copy)NSString *courseId;
@end
