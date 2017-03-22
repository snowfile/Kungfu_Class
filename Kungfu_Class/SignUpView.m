//
//  SignUpView.m
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SignUpView.h"
#import "UIView+frame.h"

@implementation SignUpView
-(void)awakeFromNib{
    [super awakeFromNib];
    _SignUpBtn.clipsToBounds = YES;
    _SignUpBtn.layer.cornerRadius = 4;
    _SignUpBtn.backgroundColor = COLOR;
    
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = 4;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}
- (IBAction)signUp:(id)sender {
    if (_shopingBlock) {
        _shopingBlock(@"");
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = 100;
}
- (IBAction)upNum:(id)sender {
    int num = [_numLab.text intValue];
    num++;
    _numLab.text = [NSString stringWithFormat:@"%d",num];
    _priceLab.text = [NSString stringWithFormat:@"￥%0.2f",num*_money];

}
- (IBAction)downNum:(id)sender {
    int num = [_numLab.text intValue];
    num--;
    _numLab.text = [NSString stringWithFormat:@"%d",num];
    _priceLab.text = [NSString stringWithFormat:@"￥%0.2f",num*_money];
}

@end
