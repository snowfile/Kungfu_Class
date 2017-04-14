//
//  SignUpViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 24/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SignUpViewController.h"
#import "WatchOrderViewController.h"
#import "LoginViewController.h"

@interface SignUpViewController ()
@property(nonatomic,retain)NSString *rStr;
@property(copy,nonatomic)NSString *cStr;
@end

@implementation SignUpViewController{
    int type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交订单";
    _bacView.clipsToBounds = YES;
    _bacView.layer.cornerRadius = 4;
    _bacView.layer.borderWidth =1;
    _bacView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _bacView.backgroundColor =[UIColor whiteColor];

    _courseNum.text = _num;
    _payNowBtn.clipsToBounds = YES;
    _payNowBtn.layer.cornerRadius = 4;
    _payNowBtn.backgroundColor = COLOR;
    
    _totalPay.text = _money;
    _shouldPay.text = _money;

    _courseNameLab.text = _courseTitle;
    _courseTimeLab.text = _courseTime;
    _teacherNameLab.text = _teacherName;
    
    [_courseImg setImageWithURL:[NSURL URLWithString:_courseImageUrl] placeholderImage:[UIImage imageNamed:@"灰色_03"]];
    type = 1;

}
- (IBAction)down:(id)sender {
    int num = [_courseNum.text intValue];
    if (num == 1) {
        return;
    }
    num --;
    _courseNum.text = [NSString stringWithFormat:@"%d",num];
    _totalPay.text = [NSString stringWithFormat:@"￥%0.2f",[_price floatValue]*num];
    _shouldPay.text = [NSString stringWithFormat:@"￥%0.2f",[_price floatValue]*num];
}
- (IBAction)up:(id)sender {
    
    int num = [_courseNum.text intValue];
    num ++;
    _courseNum.text = [NSString stringWithFormat:@"%d",num];
    _totalPay.text = [NSString stringWithFormat:@"￥%0.2f",[_price floatValue]*num];
    _shouldPay.text = [NSString stringWithFormat:@"￥%0.2f",[_price floatValue]*num];

}
- (IBAction)choosePay:(id)sender {
  
    UIButton *btn = (UIButton *)sender;
    if (btn == _weiBtn) {
        [_weiBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
        [_aliPayBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];;
        type = 1;
    }
    if(btn == _aliPayBtn){
        [_aliPayBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
        [_weiBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
        type = 2;
    }
}
- (IBAction)payNow:(id)sender {
    [self loadOrderData];
}
#pragma mark 下订单
-(void)loadOrderData{
    UserModel *usermodel = [UserModel sharedInstance];
    NSArray *array = [_totalPay.text componentsSeparatedByString:@"￥"];
    NSArray *money = array[1];
   ([MBProgressHUD showHUDAddedTo:self.view animated:YES]).labelText = @"支付中...";
    //微信
    if (type == 1) {
  
    }else{
    //支付宝
       NSDictionary *dict = @{@"accountId":[NSString stringIsNull:usermodel.accountId],@"courseId":[NSString stringIsNull:_courseId],@"price":_price,@"payMoney":money,@"nums":_courseNum.text,@"totalFee":money,@"payType":[NSString stringWithFormat:@"%d",type],@"orderType":@"1"};
        NSLog(@"dict===%@",dict);
        [NetService requestPayUrl: @"pay/order"httpMethord:@"POST" params:dict completion:^(id result,NSError *error ){
            NSLog(@"result === %@",result);
            NSString *resultCode = result[@"resultCode"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([resultCode isEqualToString:@"0"]) {
                NSDictionary *data = result[@"data"];
                NSString *orderString = data[@"orderInfo"];
                NSString *appScheme = @"KungFuClassPay";
                
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess) name:@"paySuccess" object:nil];
                
                [[AlipaySDK defaultService]payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDict){
                    if ([[resultDict objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccess" object:nil];
                    }else{
                        [MBProgressHUD showError:@"支付不成功" toView:self.view];
                    }
                }];
            }else if([resultCode isEqualToString:@"400002"]||[resultCode isEqualToString:@"40003"]||[resultCode isEqualToString:@"400004"]){
            
                LoginViewController *loginView = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginView animated:YES];
                [MBProgressHUD showError:@"你的账号在多设备登录,请重新登录确保安全" toView:loginView.view];
            }
        }];
    }

}
#pragma mark ====支付成功
-(void)paySuccess{
    WatchOrderViewController *order = [[WatchOrderViewController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
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
