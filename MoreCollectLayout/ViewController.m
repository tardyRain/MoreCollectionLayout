//
//  ViewController.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/5/27.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "ViewController.h"
#import "XYCell.h"
#import "XYReusableView.h"

#import "XYLayout.h"
#import "XYGroupLayout.h"
#import "XYCommonLayout.h"
#import "XYDecorationLayout.h"

#import "XYStackLayout.h"
#import "StackViewController.h"

#import "XYTileCollectionViewController.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XYLayout *layout = [[XYLayout alloc] init];
    
    XYGroupLayout *groupLayout = [[XYGroupLayout alloc] init];
    
    XYCommonLayout *commonLayout = [[XYCommonLayout alloc] init];
    
    XYDecorationLayout *decorationLayout = [[XYDecorationLayout alloc] init];
    
    CGRect rect = CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 520);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:decorationLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionView.decelerationRate = 1.0;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    if (@available(iOS 11.0, *)) {
        if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)])
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [_collectionView registerClass:[XYCell class] forCellWithReuseIdentifier:@"XYCell"];
    [_collectionView registerClass:[XYReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XYReusableHeadView"];
    [_collectionView registerClass:[XYReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"XYReusableFootView"];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYCell" forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"ZYH0%ld.jpg",(long)indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XYReusableView *reuseView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"XYReusableHeadView" forIndexPath:indexPath];
        reuseView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        
    }else{
        
        reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"XYReusableFootView" forIndexPath:indexPath];
        reuseView.backgroundColor = [UIColor redColor];
    }
    
    reuseView.titleLabel.text = [NSString stringWithFormat:@"第%ld段",(long)indexPath.section];
    
    return reuseView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
//    return section == 3? 0 : 9;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYStackLayout *stackLayout = [[XYStackLayout alloc] init];
    
    StackViewController *stackVC = [[StackViewController alloc] initWithCollectionViewLayout:stackLayout];
    
    [self.navigationController pushViewController:[self getTileVC] == nil? stackVC : [self getTileVC] animated:YES];
}

-(UIViewController *)getTileVC
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    flowLayout.itemSize = CGSizeMake(80, 100);
    
    XYTileCollectionViewController *vc = [[XYTileCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
