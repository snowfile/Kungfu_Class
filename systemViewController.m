
//
//  systemViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 1/8/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "systemViewController.h"

@implementation systemViewController
{
NSArray *dateArraySection;
NSArray *dateArraySectionOne;
NSArray *dateArraySectionTwo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleAndBackItem:@"系统设置"];
    
    dateArraySection = @[@"修改密码"];
    dateArraySectionOne = @[@"清除缓存",@"给我评分",@"关于功夫牙医"];
    dateArraySectionTwo = @[@"退出登录"];
    [self initSystemTableView];
}

-(void)initSystemTableView{
    self.systemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, P_Width, p_hight)];
    self.systemTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.systemTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.systemTableView.scrollEnabled = NO;
    self.systemTableView.delegate = self;
    self.systemTableView.dataSource = self;
    self.systemTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.systemTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 35)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:titleLabel];
    if (indexPath.section == 0) {
        titleLabel.text = dateArraySection[indexPath.row];
    }else if (indexPath.section == 1){
        titleLabel.text = dateArraySectionOne[indexPath.row];
    
    }else if (indexPath.section == 2){
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *logoff = [[UILabel alloc] initWithFrame:CGRectMake((P_Width-100)/2, 5, 100, 35)];
        logoff.text = dateArraySectionTwo[indexPath.row];
        logoff.textAlignment = NSTextAlignmentCenter;
        logoff.textColor = [UIColor redColor];
        logoff.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:logoff];
    }
    return cell;
}
#pragma mark 设置section头视图的高度和颜色
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return dateArraySection.count;
    }else if (section == 1)
    {
        return dateArraySectionOne.count;
    }else
        
        return dateArraySectionTwo.count;
}

@end
