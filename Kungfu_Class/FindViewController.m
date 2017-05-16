//
//  FindViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 24/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "FindViewController.h"
#import "patientDetailViewController.h"

@interface FindViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    BOOL isSearch;
    NSMutableArray *nameArray;
    NSMutableArray *searchArray;
    NSArray *searchData; //查找名称搜到的数据
}

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索患者";
    [self createTableView];
    
    nameArray = @[].mutableCopy;
    searchArray = @[].mutableCopy;
    
    [self resolverData:self.array];
    
    if (self.flag == 222) {
        [_tableView registerNib:[UINib nibWithNibName:@"patientViewCell" bundle:nil] forCellReuseIdentifier:@"patientViewCell"];
    }else if (self.flag == 333){
        [_tableView registerNib:[UINib nibWithNibName:@"RevisitCell" bundle:nil] forCellReuseIdentifier:@"RevisitCell"];
    }
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = LINECOLOR;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // 搜索视图
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    searchView.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, P_Width, 50)];
    searchBar.placeholder = @"搜索患者姓名";
    searchBar.delegate = self;
    searchBar.backgroundImage = [self buttonImageFromColor:UIColoerFromRGB(0xf5f5f5)];
    [searchView addSubview:searchBar];
    _tableView.tableHeaderView = searchView;
    [self.view addSubview:_tableView];

}
-(void)resolverData:(NSArray *)array{
    if (self.flag == 222) {
        for (NSDictionary *dict in self.array) {
            NSString *name = dict[@"name"];
            [nameArray addObject:name];
        }
    }else if (self.flag == 333){
        for (NSDictionary *dict in self.array) {
            NSString *name = dict[@"patientName"];
            [nameArray addObject:name];
        }
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [searchArray removeAllObjects];
    [self fileterBySubString:searchText];

}
-(void)fileterBySubString:(NSString *)str{
    isSearch = YES;
    //定义搜索谓词
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",str];
    //使用谓词过滤NSArray
    searchData =[nameArray filteredArrayUsingPredicate:pred];
    //让表试图重新加载数据
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag == 222) {
        return 60;
    }
    return 76;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (self.flag == 222) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"patientViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSString *friendName in searchData) {
            for (NSDictionary *dict in self.array) {
                if ([friendName isEqualToString:dict[@"name"]]) {
                    [searchArray addObject:dict];
                }
            }
        }
        UILabel *labelName = (UILabel *)[cell viewWithTag:1001];
        labelName.text = searchArray[indexPath.row][@"name"];
        
        UILabel *labelId = (UILabel *)[cell viewWithTag:1002];
        labelId.text = [NSString stringWithFormat:@"健康ID:%@",searchArray[indexPath.row][@"patientCode"]];
    }else if (self.flag == 333){
        cell = [tableView dequeueReusableCellWithIdentifier:@"RevisitCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSString *friendName in searchData) {
            for (NSDictionary *dict in self.array) {
                if ([friendName isEqualToString:dict[@"patientName"]]) {
                    [searchArray addObject:dict];
                    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1001];
                    NSString *urlString = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:searchArray[indexPath.row][@"patientIcon"]]];
                    NSURL *url = [NSURL URLWithString:urlString];
                    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"information_head"]];
                    [cell.contentView addSubview:imageView];
                    
                    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1002];
                    nameLabel.text = searchArray[indexPath.row][@"patientName"];
                    [cell.contentView addSubview:nameLabel];
                    
                    UILabel *idLabel = (UILabel *)[cell viewWithTag:1003];
                    idLabel.text =[NSString stringWithFormat:@"健康ID:%@",searchArray[indexPath.row][@"patientCode"]];
                    [cell.contentView addSubview:idLabel];
                    
                    UILabel *flagLabel = (UILabel *)[cell viewWithTag:1004];
                    [cell.contentView addSubview:flagLabel];
                    if ([searchArray[indexPath.row][@"status"] integerValue] == 0){
                        flagLabel.text = @"未";
                        flagLabel.backgroundColor = UIColoerFromRGB(0xff6600);
                    }else if([searchArray[indexPath.row][@"status"] integerValue] == 1){
                        flagLabel.text = @"已";
                        flagLabel.backgroundColor = UIColoerFromRGB(0x6ad969);
                    }else{
                        flagLabel.text = @"超";
                        flagLabel.backgroundColor = UIColoerFromRGB(0xeeeeee);
                    }
                    UILabel *timeLabel = (UILabel *)[cell viewWithTag:1005];
                    timeLabel.text = [searchArray[indexPath.row][@"visitDate"] substringFromIndex:5];
                    [cell.contentView addSubview:timeLabel];

                }
            }
        }
    
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag == 222) {
        patientDetailViewController *patientDetail = [[patientDetailViewController alloc] init];
        patientDetail.patientId = searchArray[indexPath.row][@"patientId"];
        [self.navigationController pushViewController:patientDetail animated:YES];
    }


}
-(UIImage *)buttonImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, P_Width, 50);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;


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
