//
//  AppointCollectionViewCell.h
//  Kungfu_Class
//
//  Created by 静静 on 18/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointModel.h"
#import "NSString+Regex.h"

@interface AppointCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property (weak, nonatomic) IBOutlet MyLable *nameInfoLabel;
@property (weak, nonatomic) IBOutlet MyLable *eventLabel;
@property (weak, nonatomic) IBOutlet MyLable *allergyLabel;

@property (weak, nonatomic) IBOutlet MyLable *phoneLabel;


@property(nonatomic,assign)AppointModel *model;
@end
