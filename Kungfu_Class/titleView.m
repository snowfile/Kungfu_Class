//
//  titleView.m
//  Kungfu_Class
//
//  Created by 静静 on 25/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "titleView.h"

@implementation titleView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.patientImg.layer.masksToBounds = YES;
    self.patientImg.layer.cornerRadius = self.patientImg.width/2;
    self.typeLabel.textColor = UIColoerFromRGB(0x666666);
    self.nameLabel.textColor = FIELDCOLOR;
}
@end
