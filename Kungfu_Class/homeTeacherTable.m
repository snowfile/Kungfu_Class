//
//  homeTeacherTable.m
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "homeTeacherTable.h"


@implementation homeTeacherTable
@dynamic imageView;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.layer.cornerRadius = 26.5;
    self.imageView.clipsToBounds = YES;
    
    self.nameLabel.lineBreakMode = 0;
    self.nameLabel.numberOfLines = 0;
    
    self.followBtn.layer.cornerRadius = 4;
    self.followBtn.clipsToBounds = YES;
    self.followBtn.backgroundColor = UIColoerFromRGB(0xfe8729);
}

-(void)setModel:(teacherRecommedModel *)model{

    _model = model;
    self.nameLabel.text = _model.name;
    self.fromLabel.text = _model.hospital;
    self.introlLabel.text =[NSString stringWithFormat:@"%@  %@", _model.duties,_model.teachDutties];
    
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@",_model.icon];
    NSString *ImgUrl = [NSString stringWithFormat:@"%@%@",IMG_URL,imgUrl];
    NSURL *urlImg =[NSURL URLWithString:ImgUrl];
    [self.imageView setImageWithURL:urlImg placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    
    if ([_model.attendFlag intValue] == 0) {
        [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _followBtn.layer.cornerRadius = 4;
        _followBtn.clipsToBounds = YES;
        _followBtn.backgroundColor =UIColoerFromRGB(0xfe8729);
    }else{
        [_followBtn setTitle:@"已关注" forState:UIControlStateNormal];
        _followBtn.backgroundColor = [UIColor whiteColor];
        [_followBtn setTitleColor:UIColoerFromRGB(0xfe8729) forState:UIControlStateNormal];
        _followBtn.layer.borderWidth = 1;
        _followBtn.layer.borderColor = UIColoerFromRGB(0xfe8729).CGColor;
    }
}
- (IBAction)followEvent:(id)sender {

    if (_followBlock) {
        _followBlock(_model);
    }
}
@end
