//
//  XYDecorationLayout.m
//  MoreCollectLayout
//
//  Created by wuxinyu on 2018/5/21.
//  Copyright © 2018年 desire.wu. All rights reserved.
//

#import "XYDecorationLayout.h"
#import "XYReusableView.h"

@implementation XYDecorationLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self registerClass:[XYReusableView class] forDecorationViewOfKind:@"XYReusableView"];
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        
        self.minimumInteritemSpacing = 10;
    }
    
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - 2 * self.sectionInset.left - 2 * self.minimumInteritemSpacing) /3.0;
    
    self.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 20);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    CGFloat Y = 0;
    CGFloat Height = 0;
    for (NSInteger i= 0; i<= indexPath.section; i++) {
        NSInteger row = [self.collectionView numberOfItemsInSection:indexPath.section];
        CGFloat H = ((row%3)==0?(row/3):(row/3+1))*self.itemSize.height + self.sectionInset.top + self.sectionInset.bottom;
        H += (self.headerReferenceSize.height + self.footerReferenceSize.height);
        if (indexPath.section == i) {
            Height = H;
        }else {
            Y += H;
        }
    }
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    attributes.frame = CGRectMake(0, Y, self.collectionView.frame.size.width, Height);
    attributes.zIndex = -1;
    return attributes;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect:(CGRect)rect
{
    //rect参数并不是当前的屏幕范围
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableArray *attributeArray = [[NSMutableArray alloc] init];
    
    NSInteger numberSection = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i< numberSection; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:i];
        UICollectionViewLayoutAttributes *decorationAttributes = [self layoutAttributesForDecorationViewOfKind:@"XYReusableView" atIndexPath:indexPath];
        [attributeArray addObject:decorationAttributes];
    }
    
    [attributeArray addObjectsFromArray:superArray];
    
    return [attributeArray copy];
}


@end
