//
//  CourseBaseView.m
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "CourseBaseView.h"
#import "UIView+frame.h"

@implementation CourseBaseView

-(void)awakeFromNib{
 
    [super awakeFromNib];
    
    _collectBtn.clipsToBounds = YES;
    _collectBtn.layer.cornerRadius = 4.5;
    _collectBtn.layer.borderColor = _collectBtn.titleLabel.textColor.CGColor;
    _collectBtn.layer.borderWidth = 1;
}
-(void)layoutSubviews{

    [super layoutSubviews];
    self.height = 120;

}
-(void)setOriginalPriceStr:(NSString *)originalPriceStr{

    _originalPriceStr = originalPriceStr;
    _oldPrice.text = _originalPriceStr;
    NSDictionary *attributeDic =  @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:_originalPriceStr attributes:attributeDic];
    _oldPrice.attributedText = attributeStr;
}
- (IBAction)collectEvent:(id)sender {
    if (_storeBlock) {
        _storeBlock(@"");
    }
}
@end
