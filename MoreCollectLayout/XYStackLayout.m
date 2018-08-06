//
//  XYStackLayout.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYStackLayout.h"

@interface XYStackLayout ()

@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation XYStackLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    srand(42);
    
    CGFloat minAngle = - (M_1_PI / 3);
    
    CGFloat maxAngle = M_1_PI / 3;
    
    CGFloat diff = maxAngle - minAngle;
    
    NSInteger numItems = [self.collectionView numberOfItemsInSection:0];
    
    _attributesArray = [NSMutableArray arrayWithCapacity:numItems];
    
    for (int i = 0; i < numItems; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
        attributes.size = CGSizeMake(180, 280);
        
        attributes.center = self.collectionView.center;
        
        attributes.zIndex = numItems - i - 1;
        
        CGFloat randAngle = ((((CGFloat)rand()) / RAND_MAX) * diff) + minAngle;
        
        if (i == 0) randAngle = 0;
        
        attributes.transform = CGAffineTransformMakeRotation(randAngle);
        
        if (i > 5) attributes.alpha = 0;
        
        [_attributesArray addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_attributesArray objectAtIndex:indexPath.item];
}

@end
