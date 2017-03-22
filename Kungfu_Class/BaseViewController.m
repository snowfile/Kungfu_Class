//
//  BaseViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UISearchBarDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
#pragma mark - 个性化配置tabbarItem
- (void)configTabbarItemWithTabbarItemMode:(KTabbarItemMode)tabbarItemMode{
    switch (tabbarItemMode) {
        case KTabbarItemModeHome:
            [self configtabbaritemWithTitle:@"首页" normalImageName:@"home_icon" selectedImageName:@"home_icon_selected"];
            break;
        case KTabbarItemModeClass:
            [self configtabbaritemWithTitle:@"学堂" normalImageName:@"class_icon" selectedImageName:@"class_icon_selected"];
            break;
        case KTabbarItemModeScheme:
            [self configtabbaritemWithTitle:@"看诊" normalImageName:@"scheme_icon" selectedImageName:@"scheme_icon_selected"];
            break;
        case KTabbarItemModeMine:
            [self configtabbaritemWithTitle:@"我的" normalImageName:@"mine_icon" selectedImageName:@"mine_icon_selected"];
            break;
            
        default:
            break;
    }
}

#pragma mark - 为不同的界面，配置tabbarItem
/*
 * 为不同的界面，配置tabbarItem
 * @param title             标签的题目
 * @param normalImageName   未被选中时显示的图片
 * @param selectedImageName 被选中时显示的图片
 */
- (void)configtabbaritemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName{
    UIImage *normalImage   = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    //更改title的位置
    [tabbarItem setTitlePositionAdjustment:UIOffsetMake(0, 2)];
    //更改title的字体大小
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
   self.tabBarItem=tabbarItem;
}

//#pragma mark - 初始化导航栏title同时添加back按钮
- (void)configTitleAndBackItem:(NSString *)title{
    self.title = title;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn addTarget:self action:@selector(pressedBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationController.navigationBar.barTintColor = bg_color;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem,];
  
}
-(void)configSearchBarView{
    self.navigationController.navigationBar.barTintColor = bg_color;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入名师或课程内容";
    searchBar.frame = CGRectMake(0, 0,P_Width-80,44);
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.leftBarButtonItem = searchButton;
    
    UIButton *cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(263, 0, 44, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnItem =[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"seaeach=======");
}
-(void)pressedBack{
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cancelBtnClick{
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
