//
//  SearchResult.m
//  Kungfu_Class
//
//  Created by 静静 on 06/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.height)];
    view.backgroundColor = UIColoerFromRGB(0xf7f7f7);
    self.selectedBackgroundView = view;
}
- (IBAction)deleteRow:(id)sender {
    if (_deleteBlock) {
        _deleteBlock(_row);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
