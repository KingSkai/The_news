//
//  TitleWeatherButton.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "TitleWeatherButton.h"

@implementation TitleWeatherButton

- (void)dealloc
{
    [self.titleCityLable release];
    [self.titleTemperatureLable release];
    [self.titleWeatherImageView  release];
    [super dealloc];
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTitleWeather];
    }
    return self;
}

- (void)createTitleWeather
{
    float WIDTH = self.frame.size.width;
    float HEIGHT = self.frame.size.height;
    
    self.titleCityLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH / 2, HEIGHT / 2)];
    [self.titleCityLable setBackgroundColor:[UIColor greenColor]];
    [self addSubview:self.titleCityLable];
    [self.titleCityLable release];
    
    self.titleWeatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH / 2, HEIGHT / 2, WIDTH / 2, HEIGHT / 2)];
    [self.titleWeatherImageView setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.titleWeatherImageView];
    [self.titleWeatherImageView release];
    
    self.titleWeatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT / 2, WIDTH, HEIGHT / 2)];
    [self.titleWeatherImageView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.titleWeatherImageView];
    [self.titleWeatherImageView release];
    
}

@end
