//
//  SearchViewController.m
//  Kungfu_Class
//
//  Created by 静静 on 1/16/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultView.h"
#import "LoginViewController.h"
#import "todayHotSearchView.h"
#import "TodayHotSearchModel.h"
#import "teacherDetailViewController.h"
#import "classDetailViewController.h"
#import "SearchResult.h"
#import "SearchModel.h"


@interface SearchViewController (){
    UITableView *historyTable;
    todayHotSearchView *hotsearchView;
    NSMutableArray *historyArray;
    UILabel *historyLab;
    UIButton *clearBtn;
    NSMutableArray *models;

}
@property(nonatomic,strong)SearchResultView *searchResultView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = bg_color;
    historyArray = [NSMutableArray arrayWithArray:[USERDEFAULTS objectForKey:@"History"]];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initUI];
    [self loadhotData];
}
-(void)initUI{
    self.navigationController.navigationBar.barTintColor = bg_color;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, P_Width, 44)];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.placeholder = @"请输入名师或课程内容";
    searchBar.frame = CGRectMake(0, 0,P_Width-80,44);
    searchBar.clipsToBounds = YES;
    searchBar.layer.cornerRadius = 22;
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.leftBarButtonItem = searchButton;
    
    UIButton *cancelBtn =[[UIButton alloc] initWithFrame:CGRectMake(P_Width-80, 0, 44, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnItem =[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;
    
    
    historyTable = [[UITableView alloc] initWithFrame:CGRectZero];
    historyTable.scrollEnabled = NO;
    historyTable.backgroundColor = [UIColor whiteColor];
    [historyTable registerNib:[UINib nibWithNibName:@"SearchResult" bundle:nil] forCellReuseIdentifier:@"SearchResult"];
    historyTable.delegate = self;
    historyTable.dataSource =self;
    [self.view addSubview:historyTable];
    
    if (historyArray) {
        if (historyArray.count == 0) {
        historyTable.hidden = YES;
        historyLab.hidden = YES;
    }
        historyTable.frame = CGRectMake(0, 10, P_Width, historyArray.count*45+44);
    }
    hotsearchView = [[[NSBundle mainBundle] loadNibNamed:@"todayHotSearchView" owner:nil options:nil]firstObject];
    hotsearchView.backgroundColor = [UIColor whiteColor];
    if (historyArray) {
        if (historyArray.count == 0) {
            hotsearchView.frame = CGRectMake(0, 10, P_Width, 180);
        }else{
            hotsearchView.frame = CGRectMake(0, CGRectGetMaxY(historyTable.frame)+1, P_Width, 180);
        }
    }else{
        hotsearchView.frame = CGRectMake(0, 10, P_Width, 180);
    }
    [self.view addSubview:hotsearchView];
    __weak typeof(self) weakself = self;
    hotsearchView.selectBlock = ^(NSString *content){
    
        [weakself searchDataWithStr:content];
    };
    
    _searchResultView = [[SearchResultView alloc] initWithFrame:self.view.frame];
    _searchResultView.hidden = YES;
    _searchResultView.pushVC = self;
    [self.view addSubview:_searchResultView];
    
}
-(void)loadhotData{
    [NetService requestURL:@"/school/api/common/search/tags" httpMethod:@"GET" params:nil completion:^(id result,NSError *error){
        NSString *resultCode = result[@"resultCode"];
        NSLog(@"resulttt===%@",result);
        if ([resultCode isEqualToString:@"0"]) {
           NSArray *data = result[@"data"];
            NSMutableArray *marray = [NSMutableArray array];

            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *dict = (NSDictionary *)obj;
                
                TodayHotSearchModel *model = [[TodayHotSearchModel alloc] initWithDict:dict];
                
                [marray addObject:model];
            }];

            if (marray.count == 0) {
                hotsearchView.hidden = YES;
            }else{
                hotsearchView.hidden = NO;
            }
            hotsearchView.dataMarray = marray;
        }else if ([resultCode isEqualToString:@"400002"]){
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
            //[self.navigationController pushViewController:login animated:YES];
        
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (historyArray) {
        return historyArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResult *cell = [historyTable dequeueReusableCellWithIdentifier:@"SearchResult" forIndexPath:indexPath];
    cell.searchName.text = historyArray[indexPath.row];
    cell.row = (int)indexPath.row;
      __weak  typeof(self) weakself = self;
    cell.deleteBlock = ^(int row){
        [weakself deleteRow:row];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content =historyArray[indexPath.row];
    NSLog(@"%@",content);
    [self searchDataWithStr:content];
//    SearchModel *model = models[indexPath.row];
//    if ([model.type integerValue] == 0) {
//        classDetailViewController *vc = [[classDetailViewController alloc] init];
//        vc.courseId = model.searchId;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        teacherDetailViewController *vc =[[teacherDetailViewController alloc] init];
//        vc.teacherId = model.searchId;
//        [self.navigationController pushViewController:vc animated:YES];
//    }

}
//设置头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"搜索历史";
}
//设置头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//设置头视图高度
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, P_Width, 44)];
    historyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 120, 20)];
    historyLab.text = @"搜索历史";
    [headView addSubview:historyLab];
    
    clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(P_Width-100, 4.5, 90, 35)];
    [clearBtn setImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    clearBtn.highlighted = NSNotFound;
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [clearBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:clearBtn];
   
    return headView;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *searchStr = searchText;
    if (searchText.length == 0) {
        _searchResultView.hidden = YES;
        [historyTable reloadData];
    }else{
        [self searchDataWithStr:searchStr];
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    NSLog(@"nihao dlawkdwefaef");
    return YES;

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"seaeach=======");
}
-(void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchDataWithStr:(NSString *)contentStr{
    UserModel *user = [UserModel sharedInstance];
    NSDictionary *dict = @{@"userId":user.userId,@"condition":contentStr};
    [NetService requestURL:@"/school/api/common/search" httpMethod:@"GET" params:dict completion:^(id result,NSError *error){
    
        //NSLog(@"sfhaskfhaskd11===%@",result);
        NSString *resultCode = result[@"resultCode"];
        if ([resultCode isEqualToString:@"0"]) {
            NSDictionary *data = result[@"data"];
            NSArray *searchResult = data[@"searchResult"];
            if (searchResult.count) {
                _searchResultView.hidden = NO;
               NSMutableArray * marray = [NSMutableArray array];
                [searchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){;
                    NSDictionary *dict = (NSDictionary *)obj;
                    SearchModel *model = [[SearchModel alloc]initWithDataDic:dict];
                    [marray addObject:model];
                }];
                _searchResultView.models = marray;
                models = marray;
            }else{
                _searchResultView.hidden = YES;
            }
    }
        
    }];
}
#pragma mark===
-(void)clear:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除所有的搜索历史吗?" message:nil preferredStyle:1];//这里的style是警示框的样式,0,1两种不同的风格，只有为1的时候才能添加输入框
    //[alert addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField){
    //textField.text =  @"you can type here";
   // }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [historyArray removeAllObjects];
        [USERDEFAULTS setObject:historyArray forKey:@"History"];
        [USERDEFAULTS synchronize];
        
        historyTable.height = historyArray.count*45;
        hotsearchView.frame = CGRectMake(0, 10, P_Width, 180);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
   
    
}

#pragma mark ===删除某一行
-(void)deleteRow:(int)row{
    [historyArray removeObjectAtIndex:row];
    [USERDEFAULTS setObject:historyArray forKey:@"History"];
    [USERDEFAULTS synchronize];
    [historyTable reloadData];
    historyTable.height = historyArray.count*45+40;
    
    if (historyArray.count == 0) {
        hotsearchView.frame = CGRectMake(0, 10, P_Width, 180);
    }else{
        hotsearchView.frame = CGRectMake(0, CGRectGetMaxY(historyTable.frame)+41, P_Width, 180);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recgrecreated.
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
