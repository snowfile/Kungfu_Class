//
//  CourseArrangementView.m
//  Kungfu_Class
//
//  Created by 静静 on 14/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "CourseArrangementView.h"
#import "CourseArrangementCell.h"

@implementation CourseArrangementView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_tableView registerNib:[UINib nibWithNibName:@"CourseArrangementCell" bundle:nil] forCellReuseIdentifier:@"CourseArrangementCell"];
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
  
    NSLog(@"smsmsmsms====%ld",_dataMarray.count);
      return _dataMarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    CourseArrangementCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CourseArrangementCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    NSDictionary *dataDict =_dataMarray[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"第%ld节",indexPath.row+1];
    cell.timeLabel.lineBreakMode = 0;
    cell.timeLabel.numberOfLines = 0;
    cell.timeLabel.text = [NSString stringWithFormat:@"%@~%@",dataDict[@"chapterStartTime"],dataDict[@"chapterEndTime"]];
   cell.contentLabel.text =dataDict[@"chapterDescription"];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = 220+160*_dataMarray.count;
}

@end
