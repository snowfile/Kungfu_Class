//
//  MyTextView.h
//  Kungfu_Class
//
//  Created by 静静 on 04/05/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView

/**  占位文字 **/
@property(nonatomic,copy)NSString *placeholder;

/**  占位文字颜色**/
@property(nonatomic,strong)UIColor *placeholerColor;

/** 占位文字**/
@property(nonatomic,copy)UILabel *placeholerLabel;
@end
