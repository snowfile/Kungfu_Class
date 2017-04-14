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
    
    _bacView.clipsToBounds = YES;
    _bacView.layer.cornerRadius = 4;
    _bacView.layer.borderWidth = 1;
    _bacView.layer.borderColor= [UIColor groupTableViewBackgroundColor].CGColor;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = 100;
}
- (IBAction)up:(id)sender {
    int num =[_numLab.text intValue];
    num++;
    _numLab.text = [NSString stringWithFormat:@"%d",num];
    _priceLab.text = [NSString stringWithFormat:@"￥%0.2f",_money*num];
}
- (IBAction)down:(id)sender {
    int num = [_numLab.text intValue];
    if (num == 1) {
        return;
    }
    num--;
    _numLab.text = [NSString stringWithFormat:@"%d",num];
    _priceLab.text = [NSString stringWithFormat:@"￥%0.2f",+_money*num];
}

- (IBAction)SignUp:(id)sender {
    if (_shopingBlock) {
        _shopingBlock(@"");
    }
}

@end
