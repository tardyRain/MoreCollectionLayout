//
//  StackViewController.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/13.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "StackViewController.h"
#import "XYGridViewController.h"
#import "XYCell.h"

#import "XYTransitonLayout.h"
#import "XYAnimatedTrasitioning.h"
#import "XYInterativeTransitioning.h"

@interface StackViewController ()
<
UINavigationControllerDelegate
>

@property (nonatomic,strong) XYAnimatedTrasitioning *animatedTransitioning;
@property (nonatomic, strong) XYInterativeTransitioning *interativeTransitioning;

@property (nonatomic, assign) CGPoint initialPinchPoint;
@property (nonatomic, assign) CGFloat initialMaxDidtance;
@property (nonatomic, assign) CGFloat initialPinchDistance;

@property (nonatomic, assign) BOOL isInterativeTransiton;

@end

@implementation StackViewController

static NSString * const reuseIdentifier = @"XYCell";

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title = @"Stack View";
    
    // Do any additional setup after loading the view.
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinGesture:)];
    [self.collectionView addGestureRecognizer:pinch];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XYCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"ZYH0%ld.jpg",(long)indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController pushViewController:[self nextViewControllerUseLayout:YES] animated:YES];
}

-(void)pushOrPopViewController
{
    UICollectionViewController *vc = (XYBaseCollectionViewController *)[(XYBaseCollectionViewController *)self.navigationController.topViewController nextViewControllerUseLayout:YES];
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(UICollectionViewController *)nextViewControllerUseLayout:(BOOL)useLayout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    flowLayout.itemSize = CGSizeMake(80, 80);
    
    XYGridViewController *stackVC = [[XYGridViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    stackVC.useLayoutToLayoutNavigationTransitions = useLayout;
    
    return stackVC;
}

- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    return [[XYTransitonLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];

}

#pragma mark <NavigationControllerDelegate>

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([fromVC isKindOfClass:[UICollectionViewController class]] &&
        [toVC isKindOfClass:[UICollectionViewController class]]
        &&self.isInterativeTransiton == YES
        )
    {
        self.animatedTransitioning = [[XYAnimatedTrasitioning alloc] init];
        self.animatedTransitioning.operation = operation;
        return self.animatedTransitioning;
    }
    return nil;
}

-(id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (animationController == self.animatedTransitioning)
    {
        self.interativeTransitioning= [[XYInterativeTransitioning alloc] init];
        return self.interativeTransitioning;
    }
    return nil;
}














-(void)handlePinGesture:(UIPinchGestureRecognizer *)pinchGesture
{
    if (pinchGesture.state == UIGestureRecognizerStateCancelled) {
        
        //取消
        [self finishTransitionSuccess:NO];
        
    }else if (pinchGesture.state == UIGestureRecognizerStateEnded) {
        
        //完成
        [self finishTransitionSuccess:YES];
        
    }else if (pinchGesture.state == UIGestureRecognizerStateBegan && pinchGesture.numberOfTouches == 2) {
        
        NSLog(@"beginPin");
        
        _isInterativeTransiton = YES;
        //开始
        [self pushOrPopViewController];
        
        CGPoint point1 = [pinchGesture locationOfTouch:0 inView:pinchGesture.view];
        CGPoint point2 = [pinchGesture locationOfTouch:1 inView:pinchGesture.view];
        
        CGFloat distance = sqrtf((point1.x - point2.x)*(point1.x - point2.x) + (point1.y - point2.y)*(point1.y - point2.y));
        CGFloat maxDistance =sqrtf(CGRectGetWidth(self.collectionView.frame)*CGRectGetWidth(self.collectionView.frame) +
                                   CGRectGetHeight(self.collectionView.frame)*CGRectGetHeight(self.collectionView.frame));
        
        self.initialPinchPoint = [pinchGesture locationInView:self.collectionView];
        self.initialPinchDistance = distance;
        self.initialMaxDidtance = maxDistance;
        
    }else if (pinchGesture.state == UIGestureRecognizerStateChanged && pinchGesture.numberOfTouches == 2) {
        
        //移动
        CGPoint point1 = [pinchGesture locationOfTouch:0 inView:pinchGesture.view];
        CGPoint point2 = [pinchGesture locationOfTouch:1 inView:pinchGesture.view];
        
        CGFloat distance = sqrtf((point1.x - point2.x)*(point1.x - point2.x) + (point1.y - point2.y)*(point1.y - point2.y));
        
        CGPoint point = [pinchGesture locationInView:self.collectionView];
        CGFloat offsetX = point.x - self.initialPinchPoint.x;
        CGFloat offsetY = point.y - self.initialPinchPoint.y;
        UIOffset offsetToUse = UIOffsetMake(offsetX, offsetY);
        
        CGFloat distanceDelta = distance - self.initialPinchDistance;
        
        if (self.animatedTransitioning.operation == UINavigationControllerOperationPop)
        {
            distanceDelta = -distanceDelta;
        }
        CGFloat dimension = sqrt(self.collectionView.bounds.size.width * self.collectionView.bounds.size.width + self.collectionView.bounds.size.height * self.collectionView.bounds.size.height);
        CGFloat progress = MAX(MIN((distanceDelta / dimension), 1.0), 0.0);
        
        [self updateWithProgress:progress andOffset:offsetToUse];
    }
    
}

- (void)updateWithProgress:(CGFloat)progress andOffset:(UIOffset)offset
{
    if (self.interativeTransitioning.context != nil // we must have a valid context for updates
        &&((progress != self.interativeTransitioning.transitionLayout.transitionProgress)
           || !UIOffsetEqualToOffset(offset, self.interativeTransitioning.transitionLayout.offset))
        )
    {
        [self.interativeTransitioning.transitionLayout setOffset:offset];
        [self.interativeTransitioning.transitionLayout setTransitionProgress:progress];
        [self.interativeTransitioning.transitionLayout invalidateLayout];
        [self.interativeTransitioning.context updateInteractiveTransition:progress];
    }
    
}

-(void)finishTransitionSuccess:(BOOL)success
{
    _isInterativeTransiton = NO;
    
    if (success)
    {
        [self.collectionView finishInteractiveTransition];
        [self.interativeTransitioning.context updateInteractiveTransition:1];
        [self.interativeTransitioning.context finishInteractiveTransition];
    }
    else
    {
        [self.collectionView cancelInteractiveTransition];
        [self.interativeTransitioning.context updateInteractiveTransition:0];
        [self.interativeTransitioning.context cancelInteractiveTransition];
    }
}







/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
