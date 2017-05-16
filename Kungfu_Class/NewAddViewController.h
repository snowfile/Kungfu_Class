//
//  NewAddViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 08/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface NewAddViewController : BaseNaviViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)NSArray *array;
@property(nonatomic,strong)UITableView *tableView;
@end
