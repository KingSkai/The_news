//
//  Hourly_forecastUILable.m
//  ExploreWorld
//
//  Created by dlios on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Hourly_forecastUILable.h"

@implementation Hourly_forecastUILable

- (void)dealloc
{
    [self.timeImageView release];
    [self.timeLable release];
    [self.windLable release];
    [self.rangeLable release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHourly_forecastUILable];
    }
    return self;
}

//自定义未来36小时的天气的lable
- (void)createHourly_forecastUILable
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height / 7;
    
    //时间lable
    self.timeLable = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, wid, hei )];
    [self addSubview:self.timeLable];
    [self.timeLable setTextAlignment:NSTextAlignmentCenter];
    [self.timeLable setTextColor:[UIColor grayColor]];
    [self.timeLable setFont:[UIFont systemFontOfSize:15]];
    
    //时段图标
    self.timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2 , wid/ 4 * 3 - 4, wid / 4 * 3 - 4)];
    [self.timeImageView setCenter:CGPointMake(wid / 2, hei / 2 * 3)];
    [self addSubview:self.timeImageView];
    
    //风力lable
    self.windLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei * 2, wid , hei)];
    [self.windLable setTextColor:[UIColor grayColor]];
    [self.windLable setTextAlignment:NSTextAlignmentCenter];
    [self.windLable setFont:[UIFont systemFontOfSize: 15]];
    [self addSubview:self.windLable];
    
    //气温范围lable
    self.rangeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei * 3, wid, hei * 4)];
    [self addSubview:self.rangeLable];
    

    
    
}


@end
