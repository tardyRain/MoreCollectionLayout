//
//  XYInterativeTransitioning.h
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class XYTransitonLayout;

@interface XYInterativeTransitioning : NSObject
<
UIViewControllerInteractiveTransitioning
>

@property (nonatomic) id <UIViewControllerContextTransitioning> context;
@property (nonatomic, strong) XYTransitonLayout * transitionLayout;

@end
