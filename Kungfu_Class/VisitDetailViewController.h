//
//  VisitDetailViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 09/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface VisitDetailViewController : BaseNaviViewController

@property(nonatomic,strong)NSDictionary *rebackArray;
@property(nonatomic,copy)NSString *rebackId;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,assign)NSInteger tag;

@end
