//
//  CourseBriefView.h
//  Kungfu_Class
//
//  Created by 静静 on 14/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Changeframe)(CGFloat h);
@interface CourseBriefView : UIView

@property(nonatomic,strong)Changeframe changeframe;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property(nonatomic,copy)NSString *contentStr;
@end
