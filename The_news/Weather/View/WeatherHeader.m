//
//  WeatherHeader.m
//  The_news
//
//  Created by dlios on 15/7/20.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "WeatherHeader.h"

@implementation WeatherHeader

- (void)dealloc
{
    [self.city release];
    [self.back release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeader];
    }
    return self;
}

- (void)createHeader
{
    float wei = self.frame.size.width;
    float hei = self.frame.size.height;
    
    self.city = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [self.city setCenter:CGPointMake(wei / 2, hei / 2)];
    [self addSubview:self.city];
    
    self.back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.back setCenter:CGPointMake(10, hei / 2)];
 
    [self addSubview:self.back];
}

 
@end
