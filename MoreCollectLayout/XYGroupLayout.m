//
//  XYGroupLayout.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/12.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYGroupLayout.h"

@implementation XYGroupLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(100, 100);
    
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 0);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect:(CGRect)rect
{
    //rect参数并不是当前的屏幕范围
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    NSMutableIndexSet *indexPathSet = [NSMutableIndexSet indexSet];
    
    //取到当前rect中的所有head的section
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            
            [indexPathSet addIndex:attributes.indexPath.section];
        }
    }
    
    //取出超出屏幕范围并且被复用的的head的Attributes,重新添加到数组当中;这里有一个顺序的疑问。改插入到数组中的第几个。
    [indexPathSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        
        UICollectionViewLayoutAttributes *headAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        if (headAttributes) {
            
            [superArray addObject:headAttributes];
        }
    }];
    
    //设置每一个head的位置 思路:取每个section的第一个和最后一个计算位置。 用第一个cell计算悬浮的位置 最后一个计算小时的位置
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger sectionCount = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
            
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
            
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:MAX(0, sectionCount - 1) inSection:attributes.indexPath.section];
            
            UICollectionViewLayoutAttributes *firstAttributes, *lastAttributes;//第一个和最后一个cell的attributes
            
            if (sectionCount > 0) {
                
                firstAttributes = [self layoutAttributesForItemAtIndexPath:firstIndexPath];
                
                lastAttributes = [self layoutAttributesForItemAtIndexPath:lastIndexPath];
                
            }else {
                
                CGFloat firstCell_Y = CGRectGetMaxY(attributes.frame) + self.sectionInset.top;
                
                firstAttributes = [UICollectionViewLayoutAttributes new];
                
                firstAttributes.frame = CGRectMake(0, firstCell_Y, 0, 0);
                
                lastAttributes = [firstAttributes copy];
            }
            
            
            CGFloat head_Y = CGRectGetMinY(firstAttributes.frame) - self.sectionInset.top - CGRectGetHeight(attributes.frame);
            
            CGFloat maxHead_Y = MAX(self.collectionView.contentOffset.y, head_Y);
            
            CGFloat headMiss_Y = CGRectGetMaxY(lastAttributes.frame) + self.sectionInset.bottom - CGRectGetHeight(attributes.frame);
            
            CGRect rect = attributes.frame;
            
            rect.origin.y = MIN(maxHead_Y, headMiss_Y);
            
            attributes.frame = rect;
            
            attributes.zIndex = 1;//是head位于cell的上层
        }
    }
    
    return [superArray copy];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
