//
//  MyLable.m
//  GongFuYaYi
//
//  Created by pengpeng on 16/2/26.
//  Copyright © 2016年 马卿. All rights reserved.
//

#import "MyLable.h"

@implementation MyLable

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textColor = FIELDCOLOR;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = FIELDCOLOR;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.textColor = FIELDCOLOR;
    }
    return self;
}


@end
