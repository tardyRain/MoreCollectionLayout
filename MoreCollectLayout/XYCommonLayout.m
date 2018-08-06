//
//  XYCommonLayout.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYCommonLayout.h"

@implementation XYCommonLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
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

@end
