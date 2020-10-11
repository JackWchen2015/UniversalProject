//
//  UICollectionView+WSFIndexPath.h
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (WSFIndexPath)
/**
 *  设置某一indexPath，用于记录
 *
 *  @param indexPath 目标indexPath
 */
-(void)setCurrentIndexPath:(NSIndexPath*)indexPath;


/**
 *  获取上述方法某一indexPath，把记录起来的拿回来用
 *
 *  @return 返回记录的indexPath
 */
-(NSIndexPath *)currentIndexPath;

@end

NS_ASSUME_NONNULL_END
