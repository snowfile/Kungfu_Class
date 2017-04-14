//
//  todayHotSearchView.m
//  Kungfu_Class
//
//  Created by 静静 on 10/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "todayHotSearchView.h"
#import "TodayHotSearchModel.h"

@implementation todayHotSearchView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self createUI];

}

-(void)createUI{

    CGRect rect = CGRectMake(5,55,Screen_Width-10, self.height - 55);
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout  alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowlayout];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"TodayHotSearchCell" bundle:nil] forCellWithReuseIdentifier:@"TodayHotSearchCell"];
    
    [self addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}
-(void)setDataMarray:(NSArray *)dataMarray{
    _dataMarray = dataMarray;
    NSLog(@"dataMarray = %@",dataMarray);
    [_collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataMarray.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayHotSearchCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    label.layer.borderWidth = 1;
    label.layer.cornerRadius = 8;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    TodayHotSearchModel *model = [_dataMarray objectAtIndex:indexPath.item];
    label.text = model.contentStr;
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    TodayHotSearchModel *model = [_dataMarray objectAtIndex:indexPath.item];
    return CGSizeMake(model.cellWidth, 30);
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
    
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}
//定义每个Section 的margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,10,5,10);//分别为上、左、下、右
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodayHotSearchModel *model = [_dataMarray objectAtIndex:indexPath.item];
    
    if (_selectBlock) {
        _selectBlock(model.contentStr);
    }
}
@end
