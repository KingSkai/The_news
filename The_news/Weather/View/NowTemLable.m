//
//  nowTemLable.m
//  ExploreWorld
//
//  Created by dlios on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "NowTemLable.h"

@implementation NowTemLable


- (void)dealloc
{
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildNowTemLable];
    }
    return self;
}

- (void)buildNowTemLable
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height;
    
    self.temLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wid / 4 * 3, hei)];
    [self.temLable setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:120]];
    [self.temLable setTextAlignment:NSTextAlignmentRight];
    [self.temLable setTextColor:[UIColor whiteColor]];
    [self addSubview:self.temLable];
    
    UILabel *unit = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3 + 8, 20, wid / 4, wid / 4)];
    [unit setText:@"℃"];
    [self addSubview:unit];
    [unit setFont:[UIFont systemFontOfSize:35]];
    [unit setTextColor:[UIColor whiteColor]];
    [unit release];
    
}

@end
