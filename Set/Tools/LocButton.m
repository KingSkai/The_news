//
//  LocButton.m
//  The_news
//
//  Created by dlios on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "LocButton.h"

@implementation LocButton

- (void)dealloc
{
    [self.loc release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLocButton];
    }
    return self;
}


- (void)createLocButton
{
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [ima setImage:[UIImage imageNamed:@"loc_view.png"]];
    [self addSubview:ima];
    
    self.loc = [[UILabel alloc]initWithFrame:CGRectMake( self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    [self.loc setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.loc];
}

@end
