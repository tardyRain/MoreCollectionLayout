//
//  XYAnimatedTrasitioning.h
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface XYAnimatedTrasitioning : NSObject
<
UIViewControllerAnimatedTransitioning
>

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end
