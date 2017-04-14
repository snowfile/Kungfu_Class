//
//  TeacherIntroView.m
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "TeacherIntroView.h"
#import "UIView+frame.h"

@implementation TeacherIntroView{

    CGFloat labelH;
    
    UIButton *showMoreBtn;
    CGFloat viewH;
    
    CGFloat labelShowH;
    
    CGFloat calcualH;

}
-(void)awakeFromNib{
    [super awakeFromNib];
    _teacherImg.clipsToBounds = YES;
    _teacherImg.layer.cornerRadius = 70/2;
    _teacherImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];


}
#pragma mark --设置内容简介
-(void)setContentStr:(NSString *)contentStr{
    _contentStr = [NSString stringWithFormat:@"\t%@",contentStr];
    _contentLab.text = _contentStr;
    
    //计算label的高度
    labelH = [@"" calculateLabelHeightWithText:_contentStr LabelWidth:Screen_Width-10 Font:[UIFont systemFontOfSize:16]];
    
    //字体数量超过100 因为有首行缩进有空格
    if (_contentStr.length>106) {
        
        NSString *substr = [_contentStr substringToIndex:106];
        
        CGFloat h = [@""  calculateLabelHeightWithText:substr LabelWidth:Screen_Width-10 Font:[UIFont systemFontOfSize:16]];
        
        calcualH = h;
        
        _contentLab.height = h;
        
        labelShowH = h;
        
        viewH = 130+15+h+5;
        
    }else{
        labelShowH = labelH;
        viewH = 130+labelH+10;
    }
    [self setNeedsLayout];
    
    if (_changeFrame) {
        
        _changeFrame(viewH);
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (viewH == 0) {
        viewH = 160;
    }
    self.height = viewH;
    
    _contentLab.height = labelShowH;
    _contentLab.x = 5;
    _contentLab.width = Screen_Width - 10;
    _contentLab.y = 130;
}
- (IBAction)showMore:(id)sender {
    if (_lookLectureBlock) {
        _lookLectureBlock(@"");
    }
}
-(void)singleTap:(UITapGestureRecognizer *)gr{
    if (_lookLectureBlock) {
        _lookLectureBlock(@"");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
