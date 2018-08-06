//
//  XYCell.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/5/27.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYCell.h"

@implementation XYCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6);
        
        self.imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        self.imgView.clipsToBounds = YES;
        
//        self.imgView.layer.borderWidth = 3.0;
//        self.imgView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.imgView.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
        
        [self.contentView addSubview:_imgView];
    }
    
    return self;
}

@end
