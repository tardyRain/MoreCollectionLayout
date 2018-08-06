//
//  XYImageViewController.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/6/16.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYImageViewController.h"
#import "XYImageAnimatedTransitioning.h"

@interface XYImageViewController ()
<
UINavigationControllerDelegate
>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTrasition;
@property (nonatomic, strong) XYImageAnimatedTransitioning *animatedTransitioning;
@end

@implementation XYImageViewController

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(0, 100, self.view.frame.size.width, 400);
        _imgView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_imgView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Image View";
}

-(void)viewDidAppear:(BOOL)animated
{
    UIPanGestureRecognizer *pinch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    [self.view addGestureRecognizer:pinch];
    
    self.navigationController.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateCancelled) {
        
        //取消
        if (self.interactiveTrasition.percentComplete > 0.3) {
            
            [self.interactiveTrasition updateInteractiveTransition:1];
            [self.interactiveTrasition finishInteractiveTransition];
        }
        else
        {
            [self.interactiveTrasition updateInteractiveTransition:0];
            [self.interactiveTrasition cancelInteractiveTransition];
        }
        
        self.interactiveTrasition = nil;
        
    }else if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        //完成
        if (self.interactiveTrasition.percentComplete > 0.7) {
            
            [self.interactiveTrasition updateInteractiveTransition:1];
            [self.interactiveTrasition finishInteractiveTransition];
        }
        else
        {
            [self.interactiveTrasition updateInteractiveTransition:0];
            [self.interactiveTrasition cancelInteractiveTransition];
        }
        
        self.interactiveTrasition = nil;
        
    }else if (panGesture.state == UIGestureRecognizerStateBegan) {
        
        //开始
        _interactiveTrasition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        //移动
        CGFloat progress = [panGesture translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
        progress = MIN(1.0, MAX(0.0, progress));
        [self.interactiveTrasition updateInteractiveTransition:progress];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop && fromVC == self) {
        
        _animatedTransitioning = [[XYImageAnimatedTransitioning alloc] init];
        
        return _animatedTransitioning;
    }
    else
    {
        return nil;
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController

{
    if (animationController == _animatedTransitioning) {
        
        return self.interactiveTrasition;
        
    }else{
        
        return nil;
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
