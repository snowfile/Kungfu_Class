//
//  SearchResultView.h
//  Kungfu_Class
//
//  Created by 静静 on 01/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIViewController *pushVC;
@property(nonatomic,strong)NSMutableArray *models;
@property(nonatomic,strong)UITableView *tableView;
@end
