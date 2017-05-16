//
//  visitViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "visitViewController.h"
#import "FindViewController.h"
#import "VisitDetailViewController.h"
#import "UIImage+Color.h"

@interface visitViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation visitViewController{
    NSMutableArray *revisitArray;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回访管理";
    [self initTableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RevisitCell" bundle:nil] forCellReuseIdentifier:@"RevisitCell"];
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
}
#pragma mark ==查询当天及以后的回访
-(void)loadData{
    Single *single = [Single shareSingle];
    NSDictionary *param = @{@"doctorId":single.doctorId,@"hospitalId":single.hosipitalId};
    revisitArray = @[].mutableCopy;
    [NetService requestURL:@"/dentist/api/visit/list.do" httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSLog(@"result===%@",result);
        NSString *status = result[@"resultCode"];
        NSArray *rebackList = result[@"data"][@"list"];
        if ([status isEqualToString:@"0"]) {
            [_tableView.mj_header endRefreshing];
            [rebackList enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
                [revisitArray addObject:obj];
            }];
            [_tableView reloadData];
        }
    }];
}
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *searchview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    searchview.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    searchBar.backgroundImage = [UIImage imageWithColor:UIColoerFromRGB(0xf5f5f5)];
    searchBar.placeholder = @"搜索患者姓名";
    searchBar.delegate = self;
    [searchview addSubview:searchBar];

    _tableView.tableHeaderView = searchview;

}
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    return [UIImage imageNamed:@"空数据"];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.flag = 333;
    findVC.array = revisitArray;
    [self.navigationController pushViewController:findVC animated:YES];
    return NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return revisitArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RevisitCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1001];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:revisitArray[indexPath.row][@"patientIcon"]]];
    NSURL *url = [NSURL URLWithString:urlString];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"information_head"]];
    [cell.contentView addSubview:imageView];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1002];
    nameLabel.text = revisitArray[indexPath.row][@"patientName"];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *idLabel = (UILabel *)[cell viewWithTag:1003];
    idLabel.text =[NSString stringWithFormat:@"健康ID:%@",revisitArray[indexPath.row][@"patientCode"]];
    [cell.contentView addSubview:idLabel];
    
    UILabel *flagLabel = (UILabel *)[cell viewWithTag:1004];
    [cell.contentView addSubview:flagLabel];
    if ([revisitArray[indexPath.row][@"status"] integerValue] == 0){
        flagLabel.text = @"未";
        flagLabel.backgroundColor = UIColoerFromRGB(0xff6600);
    }else if([revisitArray[indexPath.row][@"status"] integerValue] == 1){
        flagLabel.text = @"已";
        flagLabel.backgroundColor = UIColoerFromRGB(0x6ad969);
    }else{
        flagLabel.text = @"超";
        flagLabel.backgroundColor = UIColoerFromRGB(0xeeeeee);
    }
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:1005];
    timeLabel.text = [revisitArray[indexPath.row][@"visitDate"] substringFromIndex:5];
    [cell.contentView addSubview:timeLabel];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VisitDetailViewController *detailVisit = [[VisitDetailViewController alloc] init];
    detailVisit.rebackId = revisitArray[indexPath.row][@"visitId"];
    detailVisit.rebackArray = revisitArray[indexPath.row];
    if ([[revisitArray[indexPath.row][@"status"] stringValue] isEqualToString:@"0"]) {
        detailVisit.flag = 100;//未完成
    }else{
        detailVisit.flag = 200;
    }
    [self.navigationController pushViewController:detailVisit animated:YES];
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
