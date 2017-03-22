//
//  classViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 12/12/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "classViewController.h"


static int pageNum;
@interface classViewController (){
    UISegmentedControl *segmentControl;
    NSArray *dataArry;
}
@property(nonatomic,strong)UIView   *ChildView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *classArray;
@property(nonatomic,strong)NSMutableArray *arrayCount;
@end
@implementation classViewController
+(instancetype)shareInstance{
    static classViewController *classView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       classView = [[classViewController alloc] init];
    });
    return classView;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configTabbarItemWithTabbarItemMode:KTabbarItemModeClass];
    }
    return self;
}
- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = nil;
    [super viewDidLoad];
    [self getRequest];
    [self initView];
}
-(void)getRequest{
    NSDictionary *param = @{@"isRecomended":@"2",@"status":@"1"};

    [NetService requestURL:@"/school/api/courses/list" httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSString *resultCode = result[@"resultCode"];
        [self.tableView.mj_header endRefreshing];
        if ([resultCode isEqualToString:@"0"]) {
            self.classArray = result[@"data"][@"list"];
            NSMutableArray *courseList = [NSMutableArray array];
            
           [self.classArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               NSDictionary *dict = (NSDictionary *)obj;
               ClassModel *model = [[ClassModel alloc] initWithDataDic:dict];
               [courseList addObject:model];
            }];
            self.arrayCount = courseList;
            [self initChildView];
            [self changeViewVisible];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:@"加载失败" toView:self.view];
        }
    }];
}
#pragma mark上拉加载更多课程数据
-(void)requestMore{
    pageNum ++;
    NSDictionary *dict = @{@"isRecommended":@"2",@"status":@"1",@"pageNo":[NSNumber numberWithInteger:pageNum]};
    [NetService requestURL:@"/school/api/courses/list" httpMethod:@"GET" params:dict completion:^(id result, NSError *error){
        NSString *resultCode = result[@"resultCode"];
        [self.tableView.mj_footer endRefreshing];
        if ([resultCode isEqualToString:@"0"]) {
        
            self.classArray = result[@"data"][@"list"];
            if (self.classArray.count == 0) {
                [MBProgressHUD showError:@"暂无更多数据" toView:self.view];
            }else{
            NSMutableArray *courseList = [NSMutableArray arrayWithArray:self.arrayCount];
            
            [self.classArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                ClassModel *model = [[ClassModel alloc] initWithDataDic:dict];
                [courseList addObject:model];
            }];
            self.arrayCount = courseList;
            [self.tableView reloadData];
            }
        }else{
            [MBProgressHUD showError:@"加载失败" toView:self.view];
        }
    }];
}
-(void)initView{
    NSArray *arrayMenu = [[NSArray alloc] initWithObjects:@"课程学习",@"特邀名医", nil];
    segmentControl = [[UISegmentedControl alloc] initWithItems:arrayMenu];
    segmentControl.frame = CGRectMake((P_Width-195)/2, 2, 195, 35);
     segmentControl.selectedSegmentIndex = 0;
    [segmentControl.layer setBorderWidth:1];
    [segmentControl.layer setBorderColor:[UIColor whiteColor].CGColor];
    segmentControl.layer.cornerRadius = 17.5;
    [segmentControl.layer setMasksToBounds:YES];
    segmentControl.tintColor = [UIColor whiteColor];
    [segmentControl addTarget:self action:@selector(changeViewVisible) forControlEvents:UIControlEventValueChanged];
   //设置navigation的标题按钮
    self.navigationItem.titleView = segmentControl;
}
-(void)initChildView{
     pageNum = 1;
//    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 100)];
//    topImg.image = [UIImage imageNamed:@"topView"];
//    [self.view addSubview:topImg];
    
    self.ChildView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    [self.view addSubview:self.ChildView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    view.tag = 100;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassView" bundle:nil] forCellReuseIdentifier:@"ClassView"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getRequest)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    [view addSubview:self.tableView];
    
    [self.ChildView addSubview:view];
    [self initOtherViews];
    
}
#pragma mark tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayCount.count;
}
//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassView" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    ClassModel *model = _arrayCount[indexPath.row];
    //课程图片
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1001];
    NSString *str =[NSString stringWithFormat:@"%@%@",IMG_URL,model.listIcon];
    NSURL *classURL = [NSURL URLWithString:str];
    [imageView setImageWithURL:classURL];
    
    //课程名称
    UILabel *className = (UILabel *)[cell viewWithTag:1002];
    className.text = model.coursesName;
    //讲师名称
    UILabel *teacher = (UILabel *)[cell viewWithTag:1003];
    teacher.text = model.teacherName;
    
    //课程时间
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:1004];
    timeLabel.numberOfLines = 0;
    timeLabel.lineBreakMode = 0;
    NSString *timeStr = [NSString stringWithFormat:@"%@至%@",model.startTime,model.endTime];
    timeLabel.text = timeStr;
//    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor grayColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),};
//    [timeStr drawInRect:timeLabel.bounds withAttributes:dict];
    //价格
    UILabel *nowPrice = (UILabel *)[cell viewWithTag:1005];
    NSString *strNowPay = [NSString stringWithFormat:@"￥%@",model.presentPrice];
    nowPrice.text = strNowPay;
    
    UILabel *oldPrice = (UILabel *)[cell viewWithTag:1006];
    NSString *strOldPay = [NSString stringWithFormat:@"￥%@",model.originalPrice];
      oldPrice.text = strOldPay;
    //设置原价的删除线富文本格式
    NSDictionary *attriteDict = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribteStr = [[NSMutableAttributedString alloc] initWithString:strOldPay attributes:attriteDict];
    oldPrice.attributedText = attribteStr;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassModel *model = _arrayCount[indexPath.row];
   
    classDetailViewController *vc = [[classDetailViewController alloc]init];
    vc.classModel = model;
    vc.courseId = model.coursesId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeViewVisible{
    for (UIView *view in self.ChildView.subviews) {
        view.hidden=YES;
        NSLog(@"views===%@",view);
    }
    [self.ChildView viewWithTag:segmentControl.selectedSegmentIndex+100].hidden = NO;
}
#pragma mark -----添加特邀名师视图
-(void)initOtherViews{
    TeacherViewController *teacherView = [TeacherViewController new];
    [self addChildViewController:teacherView];
    [self.ChildView addSubview:teacherView.view];
    teacherView.view.tag = 101;
    [self changeViewVisible];
}
-(void)backClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
