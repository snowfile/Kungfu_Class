//
//  todayHotSearchView.h
//  Kungfu_Class
//
//  Created by 静静 on 10/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBlock)(NSString *string);

@interface todayHotSearchView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)SelectBlock selectBlock;
@property (nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataMarray;

@end
