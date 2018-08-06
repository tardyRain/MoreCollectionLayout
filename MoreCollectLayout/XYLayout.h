//
//  XYLayout.h
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/5/27.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat insetSpace;//缩进的距离
@property (nonatomic,assign) CGFloat zoomRate;//缩放的比例(计算得出)
@property (nonatomic,assign) CGFloat itemInterval;//Cell间距
@property (nonatomic,assign) CGFloat itemWidth;
@property (nonatomic,assign) CGFloat itemHeight;

@end
