//
//  AppointDetailView.h
//  Kungfu_Class
//
//  Created by 静静 on 03/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *allergyLabel;

@property(nonatomic,assign)NSArray *msgArray;

@end
