
//
//  SchemeCollectionViewCell.m
//  Kungfu_Class
//
//  Created by 静静 on 12/22/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "SchemeCollectionViewCell.h"

@implementation SchemeCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.schemeImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, self.bounds.size.width-60, 60)];
        [self.contentView addSubview:self.schemeImage];
        
        self.schemeName = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-40, 75, 80, 25)];
        self.schemeName.textAlignment = NSTextAlignmentCenter;
        self.schemeName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.schemeName];
        
    }
    return self;
}
@end
