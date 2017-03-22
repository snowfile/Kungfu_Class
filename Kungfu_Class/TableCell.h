//
//  TableCell.h
//  Kungfu_Class
//
//  Created by 静静 on 12/21/16.
//  Copyright © 2016 秦静. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property(nonatomic,strong)UIImageView *profileImg;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *hospLabel;
@property(nonatomic,strong)UILabel *posiLabel;
@property(nonatomic,strong)UIButton *followBtn;

@end
