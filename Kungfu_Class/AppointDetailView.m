//
//  AppointDetailView.m
//  Kungfu_Class
//
//  Created by 静静 on 03/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "AppointDetailView.h"

@implementation AppointDetailView

-(void)setMsgArray:(NSArray *)msgArray{
    _msgArray = msgArray;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@  %@  %@岁",self.msgArray[0],self.msgArray[1],self.msgArray[3]];
    _birthdayLabel.text = self.msgArray[2];
    _allergyLabel.text = self.msgArray[6];
    _phoneLabel.text = self.msgArray[4];
}
@end
