//
//  XYTileAnimatedTransitioning.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYTileAnimatedTransitioning.h"
#import "XYTileCollectionViewController.h"
#import "XYImageViewController.h"
#import "XYCell.h"

@implementation XYTileAnimatedTransitioning

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XYTileCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    XYImageViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    XYCell *cell = (XYCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.collectionView.indexPathsForSelectedItems[0]];
    
    UIView *snapShotView = [cell.imgView snapshotViewAfterScreenUpdates:NO];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    [containerView addSubview:snapShotView];
    
    
    cell.hidden = YES;
    
    toVC.view.alpha = 0;
    
    toVC.imgView.hidden = YES;
    
    snapShotView.frame = [containerView convertRect:cell.imgView.frame fromView:cell.imgView.superview];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toVC.view.alpha = 1.0;
        
        snapShotView.frame = [containerView convertRect:toVC.imgView.frame fromView:toVC.view];
        
    } completion:^(BOOL finished) {
        
        cell.hidden = NO;
        
        toVC.view.alpha = 1;
        
        toVC.imgView.hidden = NO;
        
        [snapShotView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];
}

@end
