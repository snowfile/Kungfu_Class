//
//  BaseViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,KTabbarItemMode) {
    KTabbarItemModeHome,//首页
    KTabbarItemModeClass,//学堂
    KTabbarItemModeScheme,//看诊
    KTabbarItemModeMine,//我的
};

@interface BaseViewController : UIViewController
//个性化配置tabbarItem
-(void)configTabbarItemWithTabbarItemMode:(KTabbarItemMode)tabbarItemMode;
/**
 *为不同的界面配置tabarItem
 *@param title  标签的题目
 *@param normalImageName 未被选中时的图片
 *@param selectedImageName 被选中时选中的图片
 *
 **/

-(void)configtabbaritemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName;
////初始化导航栏title同时添加back按钮

- (void)configTitleAndBackItem:(NSString *)title;
#pragma mark 初始化搜索导航栏界面
-(void)configSearchBarView;
@end
