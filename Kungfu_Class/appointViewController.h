//
//  appointViewController.h
//  Kungfu_Class
//
//  Created by 静静 on 20/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//
#import <EventKit/EventKit.h>
#import "FSCalendar.h"
#import "BaseNaviViewController.h"
@interface appointViewController : BaseNaviViewController
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,weak)FSCalendar *calendar;
@property(nonatomic,strong)NSCalendar *chineseCalendar;
@property(nonatomic,strong)NSArray<NSString *> *lunarChars;


@end
