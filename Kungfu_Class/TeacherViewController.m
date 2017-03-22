//
//  TeacherViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/14/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "TeacherViewController.h"
#import "teacherDetailViewController.h"
#import "teacherModels.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

static int pageNum;

@interface TeacherViewController ()
{
    UITableView *teacherTableView;
}
@property(nonatomic,strong)NSMutableArray *arrayCount;
@end

@implementation TeacherViewController
-(void)viewWillAppear:(BOOL)animated{
        [self getResource];
}
-(void)getResource{
    
    NSDictionary *param = @{@"isRecommended":@"2",@"status":@"1"};
    pageNum = 1;
    [NetService requestURL:@"/school/api/teacher/list" httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSString *resultCode = result[@"resultCode"];
        [teacherTableView.mj_header endRefreshing];
        
        if ([resultCode isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            NSArray *teacherArray = data[@"list"];
            NSMutableArray *teacherlist = [NSMutableArray array];
            [teacherArray enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx, BOOL * _Nonnull stop){
                NSDictionary *dict = (NSDictionary *)obj;
                teacherModels *model = [[teacherModels alloc] initWithDataDic:dict];
                [teacherlist addObject:model];

            }];
            self.arrayCount = teacherlist;
            [self initteachTableView];
           
        }else{
            [KVNProgress showErrorWithStatus:@"刷新失败"];
        }
    }];
}
-(void)requestMoreData{
    pageNum++;
    NSDictionary *dict = @{@"isRecommended":@"2",@"status":@"1",@"pageNo":[NSNumber numberWithInteger:pageNum]};
    [NetService requestURL:@"/school/api/teacher/list" httpMethod:@"GET" params:dict completion:^(id result,NSError *error){
        NSString *resultCode = result[@"resultCode"];
        [teacherTableView.mj_footer endRefreshing];
        if ([resultCode isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            NSArray *teacherArray = data[@"list"];
            if (teacherArray.count == 0) {
                [MBProgressHUD showError:@"暂无更多数据" toView:self.view];
            }else{
                NSMutableArray *teacherLists = [NSMutableArray arrayWithArray:self.arrayCount];
                [teacherArray enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx, BOOL * _Nonnull stop){
                    NSDictionary *dict = (NSDictionary *)obj;
                    teacherModels *model = [[teacherModels alloc] initWithDataDic:dict];
                    [teacherLists addObject:model];
                }];
                self.arrayCount = teacherLists;
                [teacherTableView reloadData];
            }
        }else{
            [MBProgressHUD showError:@"加载失败" toView:self.view];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak  typeof(self) weakself = self;

    self.lookTeacherDetailBlock = ^(teacherModels *model){
        [weakself lookTeacherDetail:model];
    };
}
-(void)initteachTableView{
    pageNum = 1;
    teacherTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight-110)];
    teacherTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    teacherTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    teacherTableView.delegate = self;
    teacherTableView.dataSource = self;
    teacherTableView.scrollEnabled = YES;
    teacherTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getResource)];
    teacherTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    [teacherTableView registerNib:[UINib nibWithNibName:@"hotTeacherViewCell" bundle:nil] forCellReuseIdentifier:@"hotTeacherViewCell"];
    [self.view addSubview:teacherTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayCount.count;
}
//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotTeacherViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    teacherModels *model = _arrayCount[indexPath.row];
    
    UIView *contentView = (UIView *)[cell viewWithTag:1000];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgProfile = (UIImageView *)[cell viewWithTag:1001];
    NSString *strImg = [NSString stringWithFormat:@"%@%@",IMG_URL,[NSString stringIsNull:model.icon]];
    NSURL *urlImg = [NSURL URLWithString:strImg];
    [imgProfile setImageWithURL:urlImg];
    imgProfile.layer.cornerRadius = 40;
    imgProfile.clipsToBounds = YES;
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1002];
    nameLabel.text = model.teacherName;
    
    UILabel *fromLabel = (UILabel *)[cell viewWithTag:1003];
    fromLabel.text = model.hospitalName;
    
    UILabel *introLabel = (UILabel *)[cell viewWithTag:1004];
    introLabel.text = model.duties;
    
    UILabel *advLabel = (UILabel *)[cell viewWithTag:1005];
    advLabel.text = model.specialty;
    
    UILabel *detailText = (UILabel *)[cell viewWithTag:1006];
    detailText.userInteractionEnabled = NO;

    detailText.text =  model.shortDesc;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    teacherModels *model = _arrayCount[indexPath.row];
    if (_lookTeacherDetailBlock) {
        _lookTeacherDetailBlock(model);
    }
}
-(void)lookTeacherDetail:(teacherModels *)model{
    teacherDetailViewController *teacherDetail =[[teacherDetailViewController alloc] init];
    teacherDetail.teacherId = model.teacherId;
    teacherDetail.teacherUserId = model.userId;
    UIBarButtonItem *bacBtn = [[UIBarButtonItem alloc] init];
    bacBtn.title = @" ";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = bacBtn;
    teacherDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:teacherDetail animated:YES];

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
