//
//  CourseArrangementView.m
//  Kungfu_Class
//
//  Created by 静静 on 14/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "CourseArrangementView.h"
#import "UIView+frame.h"

@implementation CourseArrangementView

-(void)awakeFromNib{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setDataMarray:(NSMutableArray *)dataMarray{
    _dataMarray = dataMarray;
    [self.tableView reloadData];
    if (_changeFrame) {
        _changeFrame(220+160*_dataMarray.count);
    }
}
#pragma mark --- 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataMarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseArrangementCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    NSDictionary *dataDict =_dataMarray[indexPath.row];
    UILabel *sectionLab = (UILabel *)[cell viewWithTag:1001];
    sectionLab.text = [NSString stringWithFormat:@"第%ld节",indexPath.row+1];
    NSLog(@"ceshi==%@",dataDict[@"chapterDescription"]);
    UILabel *timeLab = (UILabel *)[cell viewWithTag:1002];
    
    UILabel *contentLab = (UILabel *)[cell viewWithTag:1003];
    contentLab.text = dataDict[@"chapterDescription"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
@end
