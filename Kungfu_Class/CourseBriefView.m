//
//  CourseBriefView.m
//  Kungfu_Class
//
//  Created by 静静 on 14/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "CourseBriefView.h"
#import "UIView+frame.h"

@implementation CourseBriefView
{  //label的实际高度
    CGFloat labelH;
    //展示更多button
    UIButton *showMoreBtn;
    //View自己变化之后的高度
    CGFloat viewH;
    //label展示的高度
    CGFloat labelShowH;
    //计算的高度
    CGFloat calcuaH;
    
    BOOL isclick;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)setContentStr:(NSString *)contentStr{
    _contentStr = [NSString stringWithFormat:@"\t%@",contentStr];
    _contentLab.text = _contentStr;
    
    labelH = [@""   calculateLabelHeightWithText:_contentStr LabelWidth:Screen_Width-10 Font:[UIFont systemFontOfSize:15]];
    
    if (_contentStr.length>156) {
        NSString *substr = [_contentStr substringFromIndex:106];
        CGFloat h = [@"" calculateLabelHeightWithText:substr LabelWidth:Screen_Width-10 Font:[UIFont systemFontOfSize:15]];
        calcuaH = h;
        _contentLab.height = h;
        showMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width-80)/2,CGRectGetMaxY(_contentLab.frame)+15, 80, 30)];
        [showMoreBtn setImage:[UIImage imageNamed:@"up_float"] forState:UIControlStateNormal];
        [showMoreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [showMoreBtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:showMoreBtn];
        
        labelShowH = h;
        
        viewH = 40+45+h+10+5;
        
    }else{
        
        labelShowH = labelH;
        viewH = 40+labelH+10+15;
        [showMoreBtn removeFromSuperview];
        showMoreBtn = nil;
    }
    [self setNeedsLayout];
    
    if (_changeframe) {
        
      _changeframe(viewH);
    }
}
#pragma mark - 查看更多
-(void)showMore:(UIButton *)sender
{
    if (!isclick)
    {
        // [sender setTitle:@"收起" forState:UIControlStateNormal];
        isclick = YES;
        [sender setImage:[UIImage imageNamed:@"down_float"] forState:UIControlStateNormal];

        _contentLab.height = labelH;
        labelShowH = labelH;
      }else{
        isclick = NO;
        
        [sender setImage:[UIImage imageNamed:@"up_float"] forState:UIControlStateNormal];
        _contentLab.height = calcuaH;
        labelShowH =calcuaH;
    }
    
    viewH = 40+45+labelShowH+5;
    
    [self setNeedsLayout];
    
    if (_changeframe) {
        _changeframe(viewH);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (viewH==0) {
        viewH = 150;
    }
    self.height = viewH;
    
   _contentLab.height = labelShowH;
   _contentLab.x = 5;
   _contentLab.width = Screen_Width-10;
   _contentLab.y = 45;
    
    if (showMoreBtn) {
        showMoreBtn.y = CGRectGetMaxY(_contentLab.frame)+10;
    }
    }
@end
