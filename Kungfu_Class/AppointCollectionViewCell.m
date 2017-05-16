//
//  AppointCollectionViewCell.m
//  Kungfu_Class
//
//  Created by 静静 on 18/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "AppointCollectionViewCell.h"
#import <MASConstraintMaker.h>

@implementation AppointCollectionViewCell{
    UILabel *flagLabel;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    flagLabel = [UILabel new];
    [_statusImage addSubview:flagLabel];
    flagLabel.textColor = [UIColor whiteColor];
    flagLabel.textAlignment = NSTextAlignmentCenter;
    flagLabel.font = [UIFont systemFontOfSize:13];
    [flagLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.centerY.mas_equalTo(_statusImage.center);
        maker.left.equalTo(_statusImage.mas_left).with.offset(2);
        maker.right.equalTo(_statusImage.mas_right);
        maker.top.equalTo(_statusImage.mas_top);
        maker.bottom.equalTo(_statusImage.mas_bottom);
    }];
}
-(void)setModel:(AppointModel *)model{
    _model = model;
    
    NSString *startTime = [_model.startTime substringToIndex:5];
    NSString *endTime = [_model.endTime substringToIndex:5];
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    
    if ([[_model.isFirstTime stringValue] isEqualToString:@"0"]) {
        _statusLabel.text = @"复诊";
    }else{
    _statusLabel.text =  @"初诊";
    }

    NSString *appointStatus = @"";
    if ([[model.reserveStatus stringValue] isEqualToString:@"0"]) {
        appointStatus = @"未";
        _bgView.backgroundColor = UIColoerFromRGB(0xff6600);
    }else if ([[model.reserveStatus stringValue] isEqualToString:@"1"]||[[model.reserveStatus stringValue] isEqualToString:@"3"]){
        appointStatus = @"超";
        _bgView.backgroundColor = UIColoerFromRGB(0xcccccc);
    }else if ([[model.reserveStatus stringValue] isEqualToString:@"2"]) {
        appointStatus = @"完";
        _bgView.backgroundColor = UIColoerFromRGB(0x6ad969);
    }
    flagLabel.text = appointStatus;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   
    NSString *age = [NSString stringIsNull:_model.birthday];
    if ([age isEqualToString:@""]) {
        age = @"0";
    }else{
        NSDate *date = [dateFormatter dateFromString:age];
        age = [NSString ageWithDateOfBirth:date];
    }
    NSString *gender = @"";
    if ([[_model.gender stringValue] isEqualToString:@"0"]) {
        gender = @"男";
    }else{
    gender = @"女";
    }
    NSString *messageStr = [NSString stringWithFormat:@"%@  %@  %@岁",_model.patientName,gender,age];
    _nameInfoLabel.text = messageStr;
    _eventLabel.text = [NSString stringIsNull:_model.reserveItems];
    _allergyLabel.text = [NSString stringIsNull:_model.allergies];
    _phoneLabel.text = _model.mobile;
}
@end
