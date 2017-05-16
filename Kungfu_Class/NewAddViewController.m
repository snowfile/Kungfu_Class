//
//  NewAddViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 08/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "NewAddViewController.h"
#import "AppointedetailViewController.h"
#import "patientDetailViewController.h"
#import "VisitDetailViewController.h"

@interface NewAddViewController (){
    
    NSMutableArray *appointArray;
    NSMutableArray *appointIdArray;
    NSMutableArray *revisitArray;
    NSMutableArray *patientArray;
    NSMutableArray *patientIdArray;
}

@end

@implementation NewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.tag == 100) {
        self.title = @"新增预约";
    }else if (self.tag == 200){
        self.title = @"新增回访";
    }else{
        self.title = @"新增患者";
    }
    [self xxxData:self.array];
    [self createView];
}
-(void)xxxData:(NSArray *)array{
    if (self.tag == 100) {
        appointArray = @[].mutableCopy;
        appointIdArray = @[].mutableCopy;
        [array enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
            [appointArray addObject:obj];
        
            NSString *appointId = obj[@"id"];
            [appointIdArray addObject:appointId];
        }];
    }else if (self.tag == 200){
        revisitArray = @[].mutableCopy;
        [array enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL *_Nonnull stop){
            [revisitArray addObject:obj];
        }];
    }else{
        patientArray = @[].mutableCopy;
        patientIdArray = @[].mutableCopy;
        [array enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
            NSArray *patientId = [obj objectForKey:@"id"];
            [patientIdArray addObject:patientId];
    
            [patientArray addObject:obj];
        }];
    }
}
-(void)createView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight) style:UITableViewStylePlain];
    _tableView.separatorColor = LINECOLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"空数据"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
     cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 44, 44)];
    imageView.image = [UIImage imageNamed:@"information_head"];
    [cell.contentView addSubview:imageView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(65, 8, 80, 20)];
    name.font = [UIFont systemFontOfSize:14];
    name.textColor = [UIColor blackColor];
    [cell.contentView addSubview:name];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(65, 32, 240, 20)];
    detail.font = [UIFont systemFontOfSize:13];
    detail.textColor =[UIColor grayColor];
    [cell.contentView addSubview:detail];
    
    if (self.tag == 100) {
        name.text = self.array[indexPath.row][@"patientName"];
        
        detail.text = [NSString stringWithFormat:@"预约时间:%@",self.array[indexPath.row][@"reserveDate"]];
    }else if (self.tag == 200){
        name.text = self.array[indexPath.row][@"patientName"];
    
        detail.text = [NSString stringWithFormat:@"回访时间:%@",self.array[indexPath.row][@"visitDate"]];
    }else if (self.tag == 300){
        name.text = self.array[indexPath.row][@"real_name"];
        detail.text = [NSString stringWithFormat:@"健康ID:%@",self.array[indexPath.row][@"patient_code"]];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 100) {
        AppointedetailViewController *appoint = [[AppointedetailViewController alloc] init];
        appoint.appointId = appointIdArray[indexPath.row];
        if ([[appointArray[indexPath.row][@"reserveStatus"] stringValue]  isEqualToString:@"0"]) {
            appoint.tag = 101;
        }else if ([[appointArray[indexPath.row][@"reserveStatus"] stringValue]  isEqualToString:@"1"]){
            appoint.tag = 102;
        }else{
            appoint.tag = 103;
        }
        appoint.flag = 99;
        [self.navigationController pushViewController:appoint animated:YES];
    }else if (self.tag == 200){
        VisitDetailViewController *visit = [[VisitDetailViewController alloc] init];
        visit.rebackId = revisitArray[indexPath.row][@"visitId"];
        visit.rebackArray = revisitArray[indexPath.row];
        [self.navigationController pushViewController:visit animated:YES];
    }else{
        patientDetailViewController *patient = [[patientDetailViewController alloc] init];
        patient.patientId = patientIdArray[indexPath.row];
        patient.flag = 99;
        [self.navigationController pushViewController:patient animated:YES];
    }
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
