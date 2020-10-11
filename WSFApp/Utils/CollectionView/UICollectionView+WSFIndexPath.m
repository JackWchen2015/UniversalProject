//
//  UICollectionView+WSFIndexPath.m
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import "UICollectionView+WSFIndexPath.h"
static NSString * const KIndexPathKey = @"kIndexPathKey";
@implementation UICollectionView (WSFIndexPath)
-(void)setCurrentIndexPath:(NSIndexPath *)indexPath
{
    //通过此函数保存indexPath
    objc_setAssociatedObject(self, &KIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSIndexPath *)currentIndexPath
{
    NSIndexPath * indexPath = objc_getAssociatedObject(self, &KIndexPathKey);
    return indexPath;
}
@end
