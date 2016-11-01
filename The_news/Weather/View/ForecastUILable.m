//
//  ForecastUILable.m
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ForecastUILable.h"

@implementation ForecastUILable

- (void)dealloc
{
    [self.dLable release];
    [self.dateLable release];
    [self.forecastImageView release];
    [self.forecasTitletLable release];
    [self.forecastTHLable release];
    [self.forecastTLLable release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createMyForecastLable];
    }
    return self;
}

//自定义未来几天天气的lable
- (void)createMyForecastLable
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height / 9;
    
    //周几
    self.dLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wid, hei)];
    [self.dLable setTextAlignment:NSTextAlignmentCenter];
    [self.dLable setFont:[UIFont systemFontOfSize:10]];
    [self.dLable setTextColor:[UIColor blackColor]];
    [self addSubview:self.dLable];
    
    //日期
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei, wid, hei)];
    [self.dateLable setTextAlignment:NSTextAlignmentCenter];
    [self.dateLable setTextColor:[UIColor blackColor]];
    [self.dateLable setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:self.dateLable];
    
    
    //天气图片
    self.forecastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, wid / 4 * 3, wid / 4 * 3)];
    [self.forecastImageView setCenter:CGPointMake(wid / 2, hei * 4)];
    [self addSubview:self.forecastImageView];
    
    //天气具体情况
    self.forecasTitletLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei * 6, wid, hei)];
    [self.forecasTitletLable setTextAlignment:NSTextAlignmentCenter];
    [self.forecasTitletLable setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.forecasTitletLable];
    
    //最高气温
    self.forecastTHLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei * 7, wid, hei)];
    [self.forecastTHLable setTextAlignment:NSTextAlignmentCenter];
    [self.forecastTHLable setTextColor:[UIColor colorWithRed:1.0 green:114.0 / 255.0   blue:86.0 / 255.0 alpha:1]];
    [self.forecastTHLable setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.forecastTHLable];
    
    //最低气温
    self.forecastTLLable = [[UILabel alloc]initWithFrame:CGRectMake(0, hei * 8, wid, hei)];
    [self.forecastTLLable setTextAlignment:NSTextAlignmentCenter];
    [self.forecastTLLable setFont:[UIFont systemFontOfSize:12]];
    [self.forecastTLLable setTextColor:[UIColor cyanColor]];
    [self addSubview:self.forecastTLLable];
}

@end
