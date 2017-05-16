//
//  patientViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "patientViewController.h"
#import "patientDetailViewController.h"
#import "FindViewController.h"
#import "UIImage+Color.h"
static NSString *patientSearchPlaceHolder = @"清输入要搜索患者的姓名";
@interface patientViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UISearchBarDelegate>

@end

@implementation patientViewController{
    NSArray *patientsList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者管理";
    // Do any additional setup after loading the view.
    [self loadData];
    
    [self createTableView];
   
    [_tableView registerNib:[UINib nibWithNibName:@"patientViewCell" bundle:nil] forCellReuseIdentifier:@"patientViewCell"];
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
}
-(void)loadData{
    Single *single = [Single shareSingle];
    NSDictionary *param = @{@"doctorId":single.doctorId,@"hospital":single.hosipitalId};
    [NetService requestURL:@"/dentist/api/patient/list.do" httpMethod:@"GET" params:param completion:^(NSDictionary *result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
        if ([status isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            patientsList = [data objectForKey:@"pList"];
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
        }
    }];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight-64) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //搜索视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    [view addSubview:searchView];
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    searchbar.placeholder = patientSearchPlaceHolder;
    searchbar.delegate = self;
    searchbar.backgroundImage = [UIImage imageWithColor:UIColoerFromRGB(0xf5f5f5)];
    [searchView addSubview:searchbar];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, P_Width, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    [view addSubview:titleView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 16, 8, 22)];
    imageView.image = [UIImage imageNamed:@"竖条"];
    [titleView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 14, P_Width, 22)];
    titleLabel.text = @"患者列表";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = FIELDCOLOR;
    [titleView addSubview:titleLabel];

    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleView.bottom-1, P_Width, 1)];
    lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:lineLabel];
    
    _tableView.tableHeaderView = view;
    [self.view addSubview:_tableView];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.array = patientsList;
    findVC.flag = 222;
    [self.navigationController pushViewController:findVC animated:YES];
    return NO;


}
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return [UIImage imageNamed:@"空数据"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return patientsList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientViewCell" forIndexPath:indexPath];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1001];
    nameLabel.text = patientsList[indexPath.row][@"name"];
    UILabel *idLabel = (UILabel *)[cell viewWithTag:1002];
    idLabel.text = [NSString stringWithFormat:@"健康ID:%@",patientsList[indexPath.row][@"patientCode"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    patientDetailViewController *patientDetail = [[patientDetailViewController alloc] init];
    patientDetail.patientId = patientsList[indexPath.row][@"patientId"];
    [self.navigationController pushViewController:patientDetail animated:YES];
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
