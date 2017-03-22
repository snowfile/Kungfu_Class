//
//  homeTeacherTable.h
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "teacherRecommedModel.h"

typedef void(^followBlock)(teacherRecommedModel *model);

@interface homeTeacherTable : UITableViewCell

@property(nonatomic,strong)followBlock followBlock;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *introlLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;


@property(nonatomic,strong)teacherRecommedModel *model;

@end
