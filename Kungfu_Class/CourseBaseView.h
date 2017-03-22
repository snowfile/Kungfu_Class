//
//  CourseBaseView.h
//  Kungfu_Class
//
//  Created by 静静 on 15/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^StoreBlock)(NSString *string);

@interface CourseBaseView : UIView
@property(nonatomic,strong)StoreBlock storeBlock;
@property (weak, nonatomic) IBOutlet UILabel *nowprice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *placeLab;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;


@property (nonatomic,copy)NSString *originalPriceStr;
@end
