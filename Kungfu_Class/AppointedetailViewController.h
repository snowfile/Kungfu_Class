//
//  AppointedetailViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 20/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"
#import "AppointModel.h"

@interface AppointedetailViewController : BaseNaviViewController

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,assign)AppointModel *model;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,copy)NSString *appointId;
@property(nonatomic,copy)NSString *patientId;
@property(nonatomic,assign)NSInteger flag;

@end
