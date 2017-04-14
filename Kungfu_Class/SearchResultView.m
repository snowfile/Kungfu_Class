//
//  SearchResultView.m
//  Kungfu_Class
//
//  Created by 静静 on 01/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SearchResultView.h"
#import "SearchModel.h"
#import "SearchResult.h"
#import "classDetailViewController.h"
#import "teacherDetailViewController.h"

#define limitNum 5

@implementation SearchResultView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"SearchResult" bundle:nil] forCellReuseIdentifier:@"SearchResult"];
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return self;
}
-(void)setModels:(NSMutableArray *)models{
    _models = models;
    [_tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResult *cell = [_tableView dequeueReusableCellWithIdentifier:@"SearchResult" forIndexPath:indexPath];
    SearchModel *model = _models[indexPath.row];
    cell.delBtn.hidden = YES;
    cell.searchName.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModel *model = _models[indexPath.row];
    NSMutableArray *historyS = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"History"]];
    if ([model.type integerValue] == 0) {
        classDetailViewController *vc = [[classDetailViewController alloc] init];
        vc.courseId = model.searchId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.pushVC.navigationController pushViewController:vc animated:YES];
    }else{
        teacherDetailViewController *vc =[[teacherDetailViewController alloc] init];
        vc.teacherId = model.searchId;
        [self.pushVC.navigationController pushViewController:vc animated:YES];
    }
    if (historyS.count>= limitNum) {
        [historyS replaceObjectAtIndex:0 withObject:model.name];
    }else{
      
            if (![historyS containsObject:model.name]) {
                [historyS addObject:model.name];
            }
        }
    [USERDEFAULTS setObject:historyS forKey:@"History"];
    [USERDEFAULTS synchronize];
}
@end
