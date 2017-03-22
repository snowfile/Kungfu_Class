//
//  CourseArrangementView.h
//  Kungfu_Class
//
//  Created by 静静 on 14/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Changeframe)(CGFloat h);

@interface CourseArrangementView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Changeframe changeFrame;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataMarray;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *sponsorLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@end
