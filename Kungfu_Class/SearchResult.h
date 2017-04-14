//
//  SearchResult.h
//  Kungfu_Class
//
//  Created by 静静 on 06/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DeleteBlock)(int row);

@interface SearchResult : UITableViewCell
@property(nonatomic,strong)DeleteBlock deleteBlock;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *searchName;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property(nonatomic,assign)int row;
@end
