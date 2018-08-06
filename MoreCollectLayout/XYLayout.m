//
//  XYLayout.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/5/27.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYLayout.h"

@implementation XYLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _insetSpace = 30;//内缩距离
        _itemInterval = 10;//每一个Cell之间的间隔
        
        _itemWidth = 100;//cell的宽度
        _itemHeight = 100;//cell的高度
        
        _zoomRate = 1 - (_insetSpace - _itemInterval)/_itemWidth;
        
        self.sectionInset = UIEdgeInsetsMake(0, _insetSpace, 0, _insetSpace);//缩进
        
        self.itemSize = CGSizeMake(_itemWidth, _itemHeight);//设置每一个元素的大小
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滚动方向
        
        self.minimumLineSpacing = _itemInterval;//Cell间距
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
}

-(CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray* attributes = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *superAttribute in attributesArray) {
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:superAttribute.indexPath]];
    }
    
    return attributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attribute.size = CGSizeMake(_itemWidth, _itemHeight);
    
    //计算位置
    CGFloat itemCenter_X = _insetSpace + (_itemWidth + _itemInterval) * (indexPath.row) + _itemWidth / 2;
    
    attribute.center = CGPointMake(itemCenter_X, self.collectionView.frame.size.height/2);
    
    return attribute;
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    //newBounds: 可见区域相对于contentView的位置和大小
    return YES;
}

@end
