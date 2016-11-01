//
//  LittleUILable.m
//  ExploreWorld
//
//  Created by dlios on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "LittleUILable.h"

@implementation LittleUILable



- (void)dealloc
{
    [self.ima release];
    [self.titleLable release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLable];
    }
    return self;
}

- (void)createLable
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height;
    
    self.ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, hei, hei)];
    [self addSubview:self.ima];
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(hei + 10, 0, wid / 3 * 2, hei)];
    [self.titleLable setTextAlignment:NSTextAlignmentLeft];
    UIColor *textColor = [UIColor colorWithRed:191 green:202 blue:230 alpha:1] ;
    [self.titleLable setTextColor:textColor];
    [self.titleLable setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:self.titleLable];
}

@end
