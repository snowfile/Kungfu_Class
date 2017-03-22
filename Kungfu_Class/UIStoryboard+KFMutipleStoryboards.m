//
//  UIStoryboard+KFMutipleStoryboards.m
//  Kungfu_Class
//
//  Created by 静静 on 1/5/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "UIStoryboard+KFMutipleStoryboards.h"

@implementation UIStoryboard (KFMutipleStoryboards)

+(SystemSettingViewController *)systemsettingStoryboard_start{

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"SystemSetting" bundle:nil];
    return (SystemSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SystemSettingViewController"];
}

@end
