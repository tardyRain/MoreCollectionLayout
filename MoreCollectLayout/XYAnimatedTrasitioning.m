//
//  XYAnimatedTrasitioning.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYAnimatedTrasitioning.h"

@implementation XYAnimatedTrasitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
}


@end
