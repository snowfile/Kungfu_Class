//
//  PayAttentionView.m
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "PayAttentionView.h"
#import "UIView+frame.h"

@implementation PayAttentionView
{
    CGFloat viewH;
    
    CGFloat labelShowH;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark --设置内容简介
-(void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    _contentLab.text = _contentStr;
    
    //计算label的高度
    labelShowH = [@"" calculateLabelHeightWithText:_contentStr LabelWidth:Screen_Width-10 Font:[UIFont systemFontOfSize:16]];
    _contentLab.height = labelShowH;
    viewH = 40+ labelShowH +15;
    [self setNeedsLayout];
    if (_chanageFrme) {
        _chanageFrme(viewH);
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (viewH == 0) {
        viewH = 150;
    }
    self.height = viewH;
    
    _contentLab.height = labelShowH;
    _contentLab.x = 5;
    _contentLab.width = Screen_Width-10;
    _contentLab.y = 40;
}
@end
