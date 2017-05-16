//
//  PersonalViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 16/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *personalTableView;
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    _titleArray = @[@"姓名",@"性别",@"生日",@"年龄"];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initView];
}
-(void)initView{
    _personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    _personalTableView.scrollEnabled = NO;
    _personalTableView.showsVerticalScrollIndicator = NO;
    _personalTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _personalTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_personalTableView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    
    return 60;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    UILabel *titleLabel  = [[UILabel alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 30;
    imageView.backgroundColor = [UIColor greenColor];
   //设置个人信息的头像
    UserModel *usermodel = [UserModel sharedInstance];
    if ([usermodel.imgURL isEqualToString:@""]) {
        imageView.image = [UIImage imageNamed:@"people"];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",IMG_URL,usermodel.imgURL];
        NSURL *url = [NSURL URLWithString:urlStr];
        [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"people"]];
    }
    UILabel *infoLabel = [[UILabel alloc] init];
    if (indexPath.section== 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        titleLabel.frame = CGRectMake(20, 30, 60, 20);
        imageView.frame = CGRectMake(P_Width-100, 10, 60, 60);
        titleLabel.text = @"头像";
    }else if (indexPath.section == 1){
    titleLabel.frame = CGRectMake(20, 20, 60, 20);
        titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _titleArray[indexPath.row];
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(P_Width-80, 20, 70, 20)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            infoLabel.text = usermodel.userName;
        }else if (indexPath.row == 1){
            if ([usermodel.gender isEqualToString:@"0"]) {
                infoLabel.text = @"男";
            }else{
                infoLabel.text = @"女";
            }
        }else if (indexPath.row == 2){
            infoLabel.frame = CGRectMake(P_Width-130, 20, 120, 20);
            infoLabel.text = usermodel.birthday;
        }else{
            NSDate *date = [NSDate date];
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString *nowDate = [df stringFromDate:date];
            NSString *selectYear = [usermodel.birthday substringWithRange:NSMakeRange(0, 4)];
        
            NSString *nowYear = [nowDate substringWithRange:NSMakeRange(0, 4)];
            int age = [nowYear intValue]-[selectYear intValue];
            infoLabel.text = [NSString stringWithFormat:@"%d",age];
            
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:infoLabel];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



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
