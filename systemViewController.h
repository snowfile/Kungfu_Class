//
//  systemViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 1/8/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseViewController.h"

@interface systemViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *systemTableView;
@end
