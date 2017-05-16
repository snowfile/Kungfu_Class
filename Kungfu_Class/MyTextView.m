//
//  MyTextView.m
//  Kungfu_Class
//
//  Created by 静静 on 04/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setViewAttribute];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setViewAttribute];
    }
    return self;
}
-(void)setViewAttribute{
    self.layer .borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChabgeNotification) name:UITextViewTextDidChangeNotification object:nil];
}
-(void)setTag:(NSInteger)tag{
    if (tag == 999) {
        self.font = [UIFont systemFontOfSize:17];
    }
}
//懒加载
-(UILabel *)placeholerLabel{
    if (_placeholerLabel == nil) {
        UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 26)];
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        if (self.tag == 999) {
            placeHolderLabel.font = [UIFont systemFontOfSize:17];
        }
        placeHolderLabel.numberOfLines = 0;
        [self addSubview:placeHolderLabel];
        _placeholerLabel = placeHolderLabel;
    }
    return _placeholerLabel;
}

-(void)textDidChabgeNotification{
    self.placeholerLabel.hidden = self.hasText;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}
@end
