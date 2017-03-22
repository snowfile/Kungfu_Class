//
//  TableCell.m
//  Kungfu_Class
//
//  Created by 静静 on 12/21/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 60, 60)];
        self.profileImg.layer.cornerRadius = 25;
        self.profileImg.clipsToBounds = YES;
        [self.profileImg setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.profileImg];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 2, 50, 20)];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
    
    
        self.hospLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 2, 150, 20)];
        self.hospLabel.font = [UIFont systemFontOfSize:14];
        self.hospLabel.textColor = [UIColor orangeColor];
        self.hospLabel.numberOfLines = 0;
        self.hospLabel.lineBreakMode = 0;
        [self.contentView addSubview:self.hospLabel];
        
        self.posiLabel= [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 150, 30)];
        self.posiLabel.font = [UIFont systemFontOfSize:12];
        self.posiLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.posiLabel];
        
        
        self.followBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.followBtn.frame = CGRectMake(self.contentView.bounds.size.width-62, 20, 60, 40);
        [self.followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.followBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.followBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [self.followBtn.layer setBorderWidth:1];
        [self.followBtn.layer setMasksToBounds:YES];
        [self.contentView addSubview:self.followBtn];
        
    }
    return self;
}
@end
