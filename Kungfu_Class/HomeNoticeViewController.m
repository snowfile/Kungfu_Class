//
//  HomeNoticeViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 2/14/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "HomeNoticeViewController.h"

@interface HomeNoticeViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataMarray;

@end

@implementation HomeNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"消息中心";
    [self loadNullPage];
    [self loadData];
}
-(void)loadData{
    UserModel *userModel = [UserModel sharedInstance];
    NSDictionary *dict = @{@"receiver":userModel.userId,@"direct":@"0",@"limit":@"10"}
    ;
    [NetService requestURL:@"http://112.124.40.77:8081/kpush/history/query" httpMethod:@"POST" params:dict completion:^(id result,NSError *error){
        NSLog(@"result ===%@",result);
    }];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
    UILabel *timeLab = (UILabel *)[cell viewWithTag:1001];
    timeLab.text = _dataMarray[indexPath.row][@"timeString"];
    
    UILabel *contentLab = (UILabel*)[cell viewWithTag:1002];
    contentLab.text = _dataMarray[indexPath.row][@"content"];
    
    UILabel *titleLab = (UILabel *)[cell viewWithTag:1003];
    titleLab.text = _dataMarray[indexPath.row][@"title"];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}
-(void)loadNullPage{
    UIImageView *nilImg = [[UIImageView alloc] initWithFrame:CGRectMake(P_Width/2-50, p_hight/2-140, 100, 100)];
    nilImg.image = [UIImage imageNamed:@"no_data"];
    [self.view addSubview:nilImg];

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
