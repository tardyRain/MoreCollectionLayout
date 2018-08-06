//
//  XYReusableView.m
//  MoreCollectLayout
//
//  Created by xinyu.wu on 16/5/27.
//  Copyright © 2016年 desire.wu. All rights reserved.
//

#import "XYReusableView.h"

@implementation XYReusableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

@end
