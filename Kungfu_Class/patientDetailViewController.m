//
//  patientDetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 21/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "patientDetailViewController.h"
#import "AppointdetailViewController.h"
#import "JSDropmenuView.h"

#import "titleView.h"
#import "SegmentedControl.h"


@interface patientDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JSDropmenuViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong)NSArray *menuArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation patientDetailViewController{
    NSInteger tag;
    
    NSArray *patientArray;
    NSArray *titleArray;
    
    
    NSMutableArray *medicalArray;
    NSMutableArray *medicalIdArray;
    
    NSMutableArray *appointArray;
    NSMutableArray *appointIdArray;
    
    NSMutableArray *returnArray;//回访记录

    titleView *_titleView;
    SegmentedControl *segment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者详情";
    self.view.backgroundColor = [UIColor whiteColor];
    titleArray =  @[@"患者姓名",@"患者性别",@"出生日期",@"患者年龄",@"联系方式",@"联系地址",@"过敏史"];
    _menuArray = @[@{@"imageName":@"新增预约", @"title":@"新增预约"},@{@"imageName":@"新增回访", @"title":@"新增回访"}];
    
    if ([[NSString stringIsNull:self.patientId] isEqualToString:@""]) {
        [KVNProgress showErrorWithStatus: @"用户信息有误"];
        return;
    }
    [self createView];
    
    //加载患者信息
    [self loadInfoData];
    [self createNaviButton];

    
    [_tableView registerNib:[UINib nibWithNibName:@"InfoCell" bundle:nil] forCellReuseIdentifier:@"InfoCell"];
   
//    _indentiyOne = @"cellOne";
//    [_tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:_indentiyOne];
//    
    
}
-(void)createNaviButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 18, 20);
    [btn setImage:[UIImage imageNamed:@"导航右侧省略"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;


}
#pragma mark dropView的代理方法的实现
-(NSArray *)dropmenuDataSource{

    return self.menuArray;
}
-(void)dropmenuView:(JSDropmenuView *)dropmenuView didSelectedRow:(NSInteger)index{
    if (index>=self.menuArray.count) {
        return;
    }else if (index == 0){
    
    }else{

    }
}
-(void)rightButtonClick:(UIButton *)button{

    JSDropmenuView *dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(P_Width-130, 55, 120, 102)];
    dropmenuView.delegate = self;
    [dropmenuView showViewInView:self.navigationController.view];
}
-(void)createView{
    NSArray *apparray = [[NSBundle mainBundle]loadNibNamed:@"titleView" owner:nil options:nil];
    _titleView = [apparray firstObject];
    _titleView.frame = CGRectMake(0, 0, P_Width, 100);
    [_titleView.patientImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_URL,@""]] placeholderImage:[UIImage imageNamed:@"information_head"]];
    [self.view addSubview:_titleView];
    
    segment = [SegmentedControl segmentedControlFrame:CGRectMake(0, _titleView.bottom, P_Width, 50) titleDataSource:@[@"患者信息",@"电子病历",@"预约记录",@"回访记录"] backgroundColor:UIColoerFromRGB(0xfcfcfc) titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName: @".Helvetica Neue Interface" size:16.0f] selectColor:TEXTCOLOR buttonDownColor:COLOR Delegate:self];
    [self.view addSubview:segment];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segment.bottom, P_Width, p_hight-segment.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
    //
}
#pragma maek tableView的代理方法的实现
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 1) {
        return 70;
    }else if (tag == 2){
        return 70;
    }else if (tag == 3){
        return 90;
    }
    return P_Width/7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tag == 0) {
            if (patientArray.count != 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *titleLabel = (UILabel *)[cell viewWithTag:1001];
                UILabel *valueLabel = (UILabel *)[cell viewWithTag:1002];
           
                titleLabel.text = titleArray[indexPath.row];
                valueLabel.text = patientArray[indexPath.row];
                return cell;
            }
    }else if (tag == 1){
        if (medicalArray.count != 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[UITableViewCell alloc] init];
            }
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, P_Width-150, 20)];
            titleLabel.text = [NSString stringWithFormat:@"就诊时间:%@", medicalArray[indexPath.row][@"emrDate"]];
            titleLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:titleLabel];
        
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, P_Width-100, 20)];
            
            detailLabel.text = [NSString stringWithFormat:@"主诉:%@",medicalArray[indexPath.row][@"complaint"]];
            detailLabel.textColor = [UIColor grayColor];
            detailLabel.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:detailLabel];
            
            UILabel *flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(P_Width-95, 20, 50, 25)];
            flagLabel.textColor = [UIColor whiteColor];
            flagLabel.textAlignment = 1;
            flagLabel.clipsToBounds = YES;
            flagLabel.layer.cornerRadius = 8;
            [cell.contentView addSubview:flagLabel];
            if ([[medicalArray[indexPath.row][@"isFirstTime"] stringValue] isEqualToString:@"0"]) {
                flagLabel.text = @"复诊";
                flagLabel.backgroundColor = UIColoerFromRGB(0xff6600);
            }else{
                flagLabel.text = @"初诊";
                flagLabel.backgroundColor = UIColoerFromRGB(0xf8c100);
            }
            return cell;
        }
    }else if (tag ==2){
        if (appointArray != 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[UITableViewCell alloc] init];
            }
            UILabel *appoint = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, P_Width-150, 20)];
            appoint.textColor = [UIColor blackColor];
            appoint.font = [UIFont systemFontOfSize:16];
            appoint.text = [NSString stringWithFormat:@"预约事项:%@", appointArray[indexPath.row][@"reserveItems"]];
            [cell.contentView addSubview:appoint];
            
            UILabel *flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(P_Width-135, 20, 50, 25)];
            flagLabel.textColor = [UIColor whiteColor];
            flagLabel.clipsToBounds = YES;
            flagLabel.layer.cornerRadius = 8;
            flagLabel.textAlignment = 1;
            [cell.contentView addSubview:flagLabel];
            if ([[appointArray[indexPath.row][@"isFirstTime"] stringValue] isEqualToString:@"0"]) {
                flagLabel.text = @"复诊";
                flagLabel.backgroundColor = UIColoerFromRGB(0xff6600);
            }else{
                flagLabel.text = @"初诊";
                flagLabel.backgroundColor = UIColoerFromRGB(0xf8c100);
            }
            
            UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 150, 20)];
            status.font = [UIFont systemFontOfSize:15];
            status.textColor = [UIColor grayColor];
            [cell.contentView addSubview:status];
            if ([[appointArray[indexPath.row][@"reserveStatus"] stringValue] isEqualToString:@"0" ]) {
                status.text = @"状态:预约未到";
            }else if ([[appointArray[indexPath.row][@"reserveStatus"] stringValue] isEqualToString:@"1" ]){
                status.text = @"状态:预约超时";
            }else if([[appointArray[indexPath.row][@"reserveStatus"] stringValue] isEqualToString:@"2" ]){
                status.text = @"状态:预约已完成";
                
            }else {
            status.text = @"状态:失约";
            }
            return cell;
        }
    }else if (tag == 3){
        if (returnArray.count != 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[UITableViewCell alloc] init];
            }
            UILabel *visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, P_Width-80, 20)];
            visitLabel.text = [NSString stringWithFormat:@"回访时间:%@",returnArray[indexPath.row][@"visitDate"]];
            [cell.contentView addSubview:visitLabel];
            
            
            UILabel *status =[[UILabel alloc] initWithFrame:CGRectMake(P_Width-65, 35, 25, 20)];
            status.textAlignment = 1;
            status.clipsToBounds = YES;
            status.layer.cornerRadius = 8;
            status.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:status];
            if ([[returnArray[indexPath.row][@"status"]  stringValue] isEqualToString:@"0"]) {
                status.text = @"未";
                status.backgroundColor = UIColoerFromRGB(0xff6600);
            }else if ([[returnArray[indexPath.row][@"status"]  stringValue] isEqualToString:@"1"]) {
                status.text = @"完";
                status.backgroundColor = UIColoerFromRGB(0x6ad969);
            }else{
                status.text = @"";
                status.backgroundColor = UIColoerFromRGB(0xeeeeee);
            }
            UILabel *personLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, P_Width-180, 20)];
            
            personLabel.text = [NSString stringWithFormat:@"回访人员:%@",returnArray[indexPath.row][@"visitorName"]];
            personLabel.font = [UIFont systemFontOfSize:15];
            personLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:personLabel];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, P_Width-190, 20)];
            contentLabel.font = [UIFont systemFontOfSize:15];
            contentLabel.text = [NSString stringWithFormat:@"内容:%@",returnArray[indexPath.row][@"content"]];
            contentLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:contentLabel];
            
            return cell;
        }
    }
    return cell;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tag == 0) {
        return patientArray.count;
    }else if (tag == 1){
        return medicalArray.count;
    }else if (tag == 2){
        return appointArray.count;
    }else if (tag == 3){
        return returnArray.count;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 1) {
        
    }else if (tag == 3){
        AppointdetailViewController *appointDetail = [[AppointdetailViewController alloc] init];
        appointDetail.array = patientArray;
        appointDetail.rebackId = returnArray[indexPath.row][@"visitId"];
        if ([[returnArray[indexPath.row][@"status"]  stringValue]  isEqualToString:@"0"]) {
            appointDetail.tag = 101;
        }else{
            appointDetail.tag = 102;
        }
        [self.navigationController pushViewController:appointDetail animated:YES];
    }
}
#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
    
    if (selection == 0) {  //患者信息
        tag = 0;
        [self loadInfoData];
    }else if (selection == 1){  //电子病历
        tag = 1;
        [self medicalInfoData];
    }else if (selection == 2){                              //预约记录
        tag = 2;
        [self appointInfoData];
    }else if (selection == 3){             //回访记录
        tag = 3;
        [self returnInfoData];
    }
    
}
-(void)loadInfoData{
    NSString *urlString = [NSString stringWithFormat:@"/dentist/api/patient/%@/info.do",self.patientId];
    patientArray = @[];
    [NetService requestURL:urlString httpMethod:@"GET" params:nil completion:^(id result,NSError *error){
        NSLog(@"qqqq=====%@",result);
        NSString *status = [result objectForKey:@"resultCode"];
        NSDictionary *data = result[@"data"];
        if ([status isEqualToString:@"0"]) {
            patientArray = [self xxxModel:data];
            _titleView.nameLabel.text = data[@"name"];
            _titleView.typeLabel.text = [NSString stringWithFormat:@"健康ID:%@",data[@"patientCode"]];
        }
        [_tableView reloadData];
    }];
}
-(void)medicalInfoData{
    Single *single = [Single shareSingle];
    NSString *urlString = [NSString stringWithFormat:@"/dentist/api/emr/%@/list_emr.do",self.patientId];
    NSDictionary *param =  @{@"doctorId":single.doctorId};
    medicalArray = @[].mutableCopy;
    medicalIdArray = @[].mutableCopy;
    [NetService requestURL:urlString httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
        NSDictionary *data = result[@"data"];
        NSArray *emrList = [data objectForKey:@"emrList"];
        if ([status isEqualToString:@"0"]) {
            [emrList enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx, BOOL * _Nonnull stop){
                [medicalArray addObject:obj];
                NSString *medicalId =[obj objectForKey:@"id"];
                [medicalIdArray addObject:medicalId];
            }];
            [_tableView reloadData];
        }
    }];

}
-(void)appointInfoData{
    Single *single = [Single shareSingle];
    NSDictionary *param = @{
                            @"patientId":self.patientId,
                            @"doctorId":single.doctorId,
                            @"hospitalId":single.hosipitalId
                            };
    appointIdArray = @[].mutableCopy;
    appointArray = @[].mutableCopy;
    [NetService requestURL:@"/dentist/api/reserve/list.do" httpMethod:@"GET" params:param completion:^(id result, NSError *error) {
        NSString *status = [result objectForKey:@"resultCode"];
        NSDictionary *data = result[@"data"];
        NSArray *appointList = data[@"list"];
        if ([status isEqualToString:@"0"]) {
            [appointList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                [appointIdArray addObject:obj[@"id"]];
                [appointArray addObject:obj];
            }];
            [_tableView reloadData];
        }
    }];
}
-(void)returnInfoData{
    Single *single = [Single shareSingle];
    NSDictionary *param = @{
                            @"patientId":self.patientId,
                            @"doctorId":single.doctorId,
                            @"hospitalId":single.hosipitalId
                            };
    returnArray = @[].mutableCopy;
    [NetService requestURL:@"/dentist/api/visit/list.do" httpMethod:@"GET" params:param completion:^(id result, NSError *error) {
        NSString *status = [result objectForKey:@"resultCode"];
        NSDictionary *data = result[@"data"];
        NSArray *rebackList = data[@"list"];
        if ([status isEqualToString:@"0"]) {
            [rebackList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [returnArray addObject:obj];
            }];
            [_tableView reloadData];
        }
    }];
}
-(NSArray *)xxxModel:(NSDictionary *)dict{
    NSString *age = @"";
    if ([dict[@"birthday"] isEqualToString:@""]) {
        age = @"";
    }else{
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [df dateFromString:dict[@"birthday"]];
        age = [NSString ageWithDateOfBirth:date];
    }
    NSString *gender = @"";
    if ([[dict[@"gender"] stringValue] isEqualToString:@"0"]) {
        gender = @"男";
    }else {
        gender = @"女";
    }
    return @[dict[@"name"],gender,dict[@"birthday"],age,dict[@"mobile"],[NSString stringIsNull:dict[@"address"]],[NSString stringIsNull:dict[@"allergies"]]];
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
