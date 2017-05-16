//
//  SchemeTableViewCell.m
//  Kungfu_Class
//
//  Created by 静静 on 12/22/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "SchemeTableViewCell.h"

@implementation SchemeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 22.5, 20, 20)];
        [self.contentView addSubview:self.titleImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 15, 60, 18)];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 38, self.bounds.size.width-50, 16)];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

@end
