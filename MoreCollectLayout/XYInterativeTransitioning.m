//
//  XYInterativeTransitioning.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYInterativeTransitioning.h"

@implementation XYInterativeTransitioning

#pragma mark <UIViewControllerInteractiveTransitioningDelegate>
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.context = transitionContext;
    
    UICollectionViewController *fromCollectionViewController =
    (UICollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UICollectionViewController *toCollectionViewController =
    (UICollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:[toCollectionViewController view]];
    
    
    
    self.transitionLayout = (XYTransitonLayout *)[fromCollectionViewController.collectionView startInteractiveTransitionToCollectionViewLayout:toCollectionViewController.collectionViewLayout completion:^(BOOL completed, BOOL finished) {
        
        [self.context completeTransition:finished];
        self.context = nil;
        self.transitionLayout = nil;
        
    }];
    
    NSLog(@"transitionLayout = %@",self.transitionLayout);
}

@end
