//
//  XYImageAnimatedTransitioning.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYImageAnimatedTransitioning.h"
#import "XYTileCollectionViewController.h"
#import "XYImageViewController.h"
#import "XYCell.h"


@implementation XYImageAnimatedTransitioning

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XYImageViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    XYTileCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *snapShotView = [fromVC.imgView snapshotViewAfterScreenUpdates:NO];
    
    XYCell *cell = (XYCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.collectionView.indexPathsForSelectedItems[0]];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    [containerView addSubview:snapShotView];
    
    
    fromVC.imgView.hidden = YES;;
    
    fromVC.view.alpha = 1;
    
    toVC.view.alpha = 0;
    
    snapShotView.frame = [containerView convertRect:fromVC.imgView.frame fromView:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.imgView.alpha = 0;
        
        fromVC.view.alpha = 0;
        
        toVC.view.alpha = 1;
        
        snapShotView.frame = [containerView convertRect:cell.imgView.frame fromView:cell.imgView.superview];
        
    } completion:^(BOOL finished) {
        
        fromVC.imgView.hidden = NO;
        
        fromVC.view.alpha = 1;
        
        [snapShotView removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
