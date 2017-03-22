//
//  SwitchClinicVC.m
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SwitchClinicVC.h"
#import "UserModel.h"
#import "Single.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@interface SwitchClinicVC (){
    NSMutableArray *dataMarray;
    UserModel *userModel;
    Single *single;
}

@end

@implementation SwitchClinicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换诊所";
    userModel = [UserModel sharedInstance];
    single = [Single shareSingle];
    dataMarray = [NSMutableArray array];
    if ([[UserModel getPhysicalInfo][@"hList"] isKindOfClass:[NSArray class]]) {
        NSArray *array = [UserModel getPhysicalInfo][@"hList"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = (NSDictionary *)obj;
            ClinicModel *model = [[ClinicModel alloc] initWithDataDic:dict];
            if ([single.hosipitalId isEqualToString:model.hospitalId]) {
                model.selected = YES;
                _hasSelectmodel = model;
            }
            [dataMarray addObject:model];
        }];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataMarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, P_Width-60, 44)];
    [cell.contentView addSubview:nameLab];
   
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(P_Width-50, 17.5, 25, 25)];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 20;
    imageView.image = [UIImage imageNamed:@"提交成功"];
    [cell.contentView addSubview:imageView];
    
    ClinicModel *model = dataMarray[indexPath.row];
    nameLab.text = model.hospitalName;
    if (model.selected) {
        imageView.hidden = NO;
    }else{
        imageView.hidden = YES;
    }
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _hasSelectmodel.selected = NO;
    ClinicModel *model = dataMarray[indexPath.row];
    _hasSelectmodel = model;
    single.hosipitalId = model.hospitalId;
    single.doctorId = model.doctorId;
    _hasSelectmodel.selected = YES;
    [_tableView reloadData];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(popView) userInfo:nil repeats:NO];
}
-(void)popView{

 [self.navigationController popViewControllerAnimated:YES];
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
