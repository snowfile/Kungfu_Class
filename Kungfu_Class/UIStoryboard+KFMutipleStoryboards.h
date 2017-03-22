//
//  UIStoryboard+KFMutipleStoryboards.h
//  Kungfu_Class
//
//  Created by 静静 on 1/5/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SystemSettingViewController;

@interface UIStoryboard (KFMutipleStoryboards)

//Systemsetting

+(SystemSettingViewController*)systemsettingStoryboard_start;

@end
