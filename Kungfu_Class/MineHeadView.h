//
//  MineHeadView.h
//  Kungfu_Class
//
//  Created by 静静 on 15/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MineHeadBlock)(NSString *title);
@interface MineHeadView : UIView
@property(nonatomic,strong)UIImageView *peopleImageView;
@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *signInBtn;

@property(nonatomic,strong)UILabel *followLab;
@property(nonatomic,strong)UILabel *classLab;
@property(nonatomic,strong)UILabel *intergralLab;

@property(nonatomic,copy)MineHeadBlock mineHeadBlock;

@end
