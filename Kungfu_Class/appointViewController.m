//
//  appointViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "appointViewController.h"
#import "addAppointeViewController.h"
#import "AppointedetailViewController.h"
#import "AppointCollectionViewCell.h"
#import "SegmentedControl.h"
#import "NSDate+Extension.h"
#import "AppointModel.h"

@interface appointViewController ()<FSCalendarDelegate,FSCalendarDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *pointArray;
    UILabel *dateLabel;
    SegmentedControl *segment;
    UIImageView *visualView;
    NSMutableArray *appointArray;
    NSMutableArray *appointIdArray;
    NSString *appointStatus;//预约状态
    NSString *dateString;
    NSInteger flag;//选择状态
}
@end

@implementation appointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约管理";
    flag = 0;
    self.view.backgroundColor = UIColoerFromRGB(0xf5f5f5);
    NSString *dateStr = [NSDate formatYMD:[NSDate new]];
    [self loadData: dateStr status:@""];
    dateString = dateStr;
    [self createNaviButton];
    [self createUI];

}
-(void)createNaviButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"新增" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(addApppoint) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)addApppoint{
    addAppointeViewController *addAppointe = [[addAppointeViewController  alloc]init];
    [self.navigationController pushViewController:addAppointe animated:YES];
}
-(void)loadData:(NSString *)dateStr status:(NSString *)status{
    Single *single = [Single shareSingle];
    appointStatus = @"";//默认加载所有
    appointArray = @[].mutableCopy;
    NSDictionary *param = @{};
    if ([status isEqualToString:@""]) {
        param = @{
                  @"doctorId":single.doctorId,
                  @"hospitalId":single.hosipitalId,
                  @"startDate":dateStr,
                  @"endDate":dateStr,
                  @"reserveStatus":status
                  };
    }else {
        param = @{
                  @"doctorId":single.doctorId,
                  @"hospitalId":single.hosipitalId,
                  @"startDate":dateStr,
                  @"endDate":dateStr,
                  @"reserveStatus":status
                  };
    }
    appointArray = @[].mutableCopy;
    appointIdArray = @[].mutableCopy;
    pointArray = @[].mutableCopy;
    [NetService requestURL:@"/dentist/api/reserve/list.do" httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
        if ([status isEqualToString:@"0"]) {
            NSLog(@"result=====%@",result);
            NSDictionary *data = [result objectForKey:@"data"];
            NSArray *appointList = data[@"list"];
            [appointList enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
                AppointModel *model = [[AppointModel alloc] initWithDataDic:obj];
                [appointArray addObject:model];
            //存放预约id的数组
                NSString *appointId = obj[@"id"];
                [appointIdArray addObject:appointId];
            
                NSString *reserveDate = obj[@"reserceDate"];
                [pointArray addObject:reserveDate];
            }];
            [self.collectionView reloadData];
        }
    }];
}
-(void)createUI{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 56)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor =[ UIColor whiteColor];
    [self.view addSubview:topView];

    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, P_Width, 56)];
    dateLabel.userInteractionEnabled = YES;
    dateLabel.font = [UIFont systemFontOfSize:16];
    dateLabel.textColor = UIColoerFromRGB(0x666666);
    dateLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAction:)];
    [dateLabel addGestureRecognizer:gr];
    dateLabel.text = [self weekByDate:[NSDate new]];
    [topView addSubview:dateLabel];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 57, P_Width, 270)];
    calendar.backgroundColor = [UIColor whiteColor];
    [calendar selectDate:[NSDate new]];
    calendar.scope = FSCalendarScopeWeek;
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view insertSubview:calendar atIndex:1];
    self.calendar = calendar;
    
    self.chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSInteger lunarDay = [self.chineseCalendar component:NSCalendarUnitDay fromDate:[NSDate new]];
    self.lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];
    
    NSArray *titleArray =  @[@"全部",@"预约未到",@"预约完成",@"预约超时"];
    segment = [SegmentedControl segmentedControlFrame:CGRectMake(0, (calendar.height)*2/7+56, P_Width, 50)titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:FIELDCOLOR titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:TEXTCOLOR buttonDownColor:COLOR Delegate:self];
    [self.view insertSubview:segment atIndex:1];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, segment.bottom+10, P_Width, p_hight-(segment.bottom+10+64)) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];

    [self.collectionView registerNib:[UINib nibWithNibName:@"AppointCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AppointCollectionViewCell"];
    [self.view insertSubview:self.collectionView atIndex:1];


    visualView = [[UIImageView alloc] initWithFrame:CGRectMake(0, calendar.bottom, P_Width, 500)];
    visualView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    [visualView addGestureRecognizer:tap];
    visualView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view insertSubview:visualView atIndex:2];
}
#pragma mark collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return appointArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AppointCollectionViewCell *cell =(AppointCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"AppointCollectionViewCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 8;
    cell.model = appointArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Screen_Width - 30, 160);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AppointedetailViewController *appointDetail = [[AppointedetailViewController alloc] init];
    appointDetail.appointId = appointIdArray[indexPath.row];
    AppointModel *model = appointArray[indexPath.row];
    if ([[model.reserveStatus stringValue] isEqualToString:@"0"]) {
        appointDetail.tag = 101;
    }else if ([[model.reserveStatus stringValue] isEqualToString:@"1"]){
        appointDetail.tag = 102;
    }else{
        appointDetail.tag = 103;
    }
    appointDetail.model = model;
    [self.navigationController pushViewController:appointDetail animated:YES];
}
-(void)hideAction{
    visualView.hidden = YES;
    _calendar.scope = FSCalendarScopeWeek;
}
                            
-(void)changeAction:(UITapGestureRecognizer *)gr{
    if (self.calendar.scope == FSCalendarScopeMonth) {
        [self.calendar setScope:FSCalendarScopeWeek animated:YES];
        visualView.hidden = YES;
    }else{
        [self.calendar setScope:FSCalendarScopeMonth animated:YES];
        visualView.hidden = NO;
    }
}
-(void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    [self.view layoutIfNeeded];
}

-(NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    NSString *dateS = [calendar stringFromDate:date format:@"yyyy-MM-dd"];
    if([pointArray containsObject:dateS]){
        return 1;
    }
    return 0;
}
-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    dateLabel.text = [self weekByDate:date];
    if (calendar.scope == FSCalendarScopeMonth) {
        calendar.scope = FSCalendarScopeWeek;
        visualView.hidden = YES;
    }
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
        [selectedDates addObject:[calendar stringFromDate:obj format:@"yyyy/MM/dd"]];
    }];
    NSString *dateStr = [NSDate formatYMD:date];
    if (flag == 0) {
        [self loadData:dateStr status:@""];
    }else if (flag == 1){
        [self loadData:dateStr status:@"0"];
    }else if (flag == 2){
        [self loadData:dateStr status:@"2"];
    }else if (flag == 3){
        [self loadData:dateStr status:@"1"];
    }
    //根据选择日期过滤数据
    dateString = dateStr;
}
//- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
//{
//    EKEvent *event = [self eventsForDate:date].firstObject;
//    if (event) {
//        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...
//    }
//    NSInteger day = [self.chineseCalendar component:NSCalendarUnitDay fromDate:date];
//    return _lunarChars[day-1]; // 初一、初二、初三...
//}

-(UIColor *)calendar:(FSCalendar *)calendar appearance:(nonnull FSCalendarAppearance *)appearance eventColorForDate:(nonnull NSDate *)date{
    NSString *dateS = [calendar stringFromDate:date format:@"yyyy-MM-dd"];
    if ([pointArray containsObject:dateS]) {
        return [UIColor purpleColor];
    }
    return nil;
}
#pragma mark ==遵守代理，实现代理方法
-(void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        [self loadData:dateString status:@""];
        flag = 0;
    }else if (selection == 1){
        [self loadData:dateString status:@"0"];
        flag =1;
    }else if (selection == 2){
        [self loadData:dateString status:@"2"];
        flag = 2;
    }else{
        [self loadData:dateString status:@"1"];
        flag = 3;
    }
}

-(NSString *)weekByDate:(NSDate *)date{
    NSString *dateStr = [NSDate formatYMD:date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterFullStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    NSString *week = [[[format stringFromDate:date]componentsSeparatedByString:@" "] lastObject];
    NSString *weekStr = @"";
    if ([week isEqualToString:@"星期一"]) {
        weekStr = @"周一";
    }else if ([week isEqualToString:@"星期二"]) {
        weekStr = @"周二";
    }else if ([week isEqualToString:@"星期三"]) {
        weekStr = @"周三";
    }else if ([week isEqualToString:@"星期四"]) {
        weekStr = @"周四";
    }else if ([week isEqualToString:@"星期五"]) {
        weekStr = @"周五";
    }else if ([week isEqualToString:@"星期六"]) {
        weekStr = @"周六";
    }else if ([week isEqualToString:@"星期日"]) {
        weekStr = @"周日";
    }
    NSString *str = [NSString stringWithFormat:@"%@ %@",dateStr,weekStr];
    return str;

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
