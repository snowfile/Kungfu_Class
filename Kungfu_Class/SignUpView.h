//
//  SignUpView.h
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GoShopingBlock)(NSString *money);

@interface SignUpView : UIView

@property(nonatomic,strong)GoShopingBlock shopingBlock;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;


@property (weak, nonatomic) IBOutlet UIButton *SignUpBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property(nonatomic,assign)float money;
@end
