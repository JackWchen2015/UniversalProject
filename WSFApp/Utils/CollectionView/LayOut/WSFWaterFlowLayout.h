//
//  WSFWaterFlowLayout.h
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFlowLayoutDelegate;

@interface WSFWaterFlowLayout : UICollectionViewLayout
@property (assign,nonatomic)CGFloat columnMargin;//每一列item之间的间距
@property (assign,nonatomic)CGFloat rowMargin;   //每一行item之间的间距
@property (assign,nonatomic)UIEdgeInsets sectionInset;//设置于collectionView边缘的间距
@property (assign,nonatomic)NSInteger columnCount;//设置每一行排列的个数


@property (weak,nonatomic)id<WaterFlowLayoutDelegate> delegate; //设置代理
@end

@protocol WaterFlowLayoutDelegate
-(CGFloat)waterFlowLayout:(WSFWaterFlowLayout *) WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
