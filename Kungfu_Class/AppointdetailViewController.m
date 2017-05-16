//
//  AppointdetailViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 03/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "AppointdetailViewController.h"
#import "AppointDetailView.h"
#import "LTPickerView.h"

@interface AppointdetailViewController ()
@property(nonatomic,strong)MyTextView *textView;
@property(nonatomic,strong)MyTextView *resultView;

@end

@implementation AppointdetailViewController{
    UIView *rebackView;
    AppointDetailView *appointDetail;
    UIButton *SaveButton;
    NSMutableArray *peopleArray;
    NSMutableArray *peopleIdArray;
    NSString *peopleId; //选中回访人员的ID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回访详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadData];
    [self createView];
   
    
    if(self.tag == 101){
        [self createNaviButton];
        [self addButton];
        [self loadRebackPeople];

    }
}
-(void)createView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, P_Width, p_hight)];
    rebackView = [[[NSBundle mainBundle] loadNibNamed:@"rebackDetail" owner:nil options:nil]lastObject];;
    rebackView.mj_y = 10;
    rebackView.width = P_Width;
    rebackView.height = 389;
    [scrollView addSubview:rebackView];
    
    appointDetail = (AppointDetailView *)[[[NSBundle mainBundle]loadNibNamed:@"AppointDetail" owner:nil options:nil]firstObject];
    appointDetail.msgArray = self.array;
    appointDetail.mj_y = rebackView.bottom +10;
    appointDetail.width = P_Width;
    appointDetail.height = 188;
    [scrollView addSubview:appointDetail];
    scrollView.contentSize = CGSizeMake(P_Width, 389+188+20);
    [self.view addSubview:scrollView];
    
}
-(void)addButton{
    UIButton *docButton = (UIButton *)[rebackView viewWithTag:442];
    docButton.hidden = NO;
    [docButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)doAction{
    LTPickerView *pickerView = [LTPickerView new];
    pickerView.dataSource = peopleArray;
    pickerView.defaultStr = @"0";//默认选择的数据
    [pickerView show];
    
    pickerView.block = ^(LTPickerView *obj,NSString *str, int num){
        UILabel *peopleLabel = (UILabel *)[rebackView viewWithTag:412];
        peopleLabel.text = str;
        peopleId = peopleIdArray[num];
    };
}
-(void)loadRebackPeople{
    Single *single = [Single shareSingle];
    NSDictionary *param = @{@"hospitalId":single.hosipitalId};
    peopleArray = @[].mutableCopy;
    peopleIdArray = @[].mutableCopy;
    [NetService requestURL:@"/dentist/api/common/getDoctorList.do" httpMethod:@"GET" params:param completion:^(id result,NSError *error){
        NSLog(@"visit===%@",result);
        NSString *status = [result objectForKey:@"resultCode"];
        NSDictionary *data = result[@"data"];
        if ([status isEqualToString:@"0"]) {
            NSArray *typeList = data[@"doctorList"];
            [typeList enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
                [peopleArray addObject:obj[@"name"]];
                [peopleIdArray addObject:obj[@"id"]];
            }];
        }
    }];
}
-(void)createNaviButton{
    SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SaveButton.frame = CGRectMake(0, 0, 60, 40);
    [SaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [SaveButton addTarget:self action:@selector(SaveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:SaveButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)SaveAction{
    Single *single = [Single shareSingle];
    NSString *urlString = [NSString stringWithFormat:@"/dentist/api/visit/%@/fill_result.do",self.rebackId];
    NSDictionary *param = @{@"accountId":single.accountId,
                            @"action":@"FINISH_VISIT",
                            @"hospitalId":single.hosipitalId,
                            @"doctorId":single.doctorId,
                            @"result":self.resultView.text};
    [NetService requestURL:urlString httpMethod:@"POST" params:param completion:^(id result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
        if ([status isEqualToString:@"0"]) {
            [KVNProgress showSuccessWithStatus:@"填写回访结果成功"];
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  NSNotification *notice = [NSNotification notificationWithName:@"addRebackNotification" object:nil userInfo:nil];
                  [[NSNotificationCenter defaultCenter]postNotification:notice];
                  [self.navigationController popViewControllerAnimated:YES];
              });
        }else if ([status isEqualToString:@"400005"]){
        
            [KVNProgress showErrorWithStatus:@"请填写回访结果"];
        }
    }];
}
//请求回访详情
-(void)loadData{
    NSString *urlString =[NSString stringWithFormat:@"/dentist/api/visit/%@/info.do",self.rebackId];
    [NetService requestURL:urlString httpMethod:@"GET" params:nil completion:^(id result,NSError *error){
        NSString *status = [result objectForKey:@"resultCode"];
        if ([status isEqualToString:@"0"]) {
            NSDictionary *data = [result objectForKey:@"data"];
            NSDictionary *visitInfo = data[@"visitInfo"];
            //回访日期
            UILabel *dateLabel = (UILabel *)[rebackView viewWithTag:410];
            dateLabel.text = visitInfo[@"visitDate"];
            
            //主治医生
            UILabel *doctorLabel = (UILabel *)[rebackView viewWithTag:411];
            doctorLabel.text = visitInfo[@"doctor"];
            
            // 回访人员
            UILabel *peopleLabel = (UILabel *)[rebackView viewWithTag:412];
            peopleLabel.text = visitInfo[@"doctor"];
            
            
            MyTextView *contentView = (MyTextView *)[rebackView viewWithTag:413];
            self.textView= contentView;
            contentView.tag = 999;
            contentView.editable = NO;
            contentView.text = visitInfo[@"content"];
            
            //结果
            MyTextView *resultView = (MyTextView *)[rebackView viewWithTag:414];
            self.resultView = resultView;
            resultView.tag = 999;
            if (self.tag == 101) {
                resultView.editable = YES;
            }else{
                resultView.editable = NO;
            }
            resultView.text = [NSString stringIsNull:visitInfo[@"result"]];
        }
    }];
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
