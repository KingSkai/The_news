//
//  WeatherDetailView.m
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "WeatherDetailView.h"

@implementation WeatherDetailView
- (void)dealloc
{
    [self.weatherImageView release];
    [self.gradeLable release];
    [self.PM25 release];
    [self.sk_sd release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMyWeatherDetailView];
    }
    return self;
}




- (void)createMyWeatherDetailView
{
    
    float wid = self.frame.size.width;
    float hei = self.frame.size.height / 5;
    UIFont *font = [UIFont systemFontOfSize:12];
    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, wid - 10, hei)];
    [l setText:@"详细信息"];
    [l setTextColor:[UIColor whiteColor]];
    [l setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:l];
    [l release];
    
    self.weatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, hei * 2, hei * 2)];
    [self.weatherImageView setCenter:CGPointMake(wid / 4, hei * 3)];
    [self addSubview:self.weatherImageView];
    
    UILabel *g = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2, hei , wid / 4, hei)];
    [g setText:@"空气质量"];
    [g setTextColor:[UIColor whiteColor]];
    [g setFont:font];
    [self addSubview:g];
    [g release];
    
    self.gradeLable = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3,hei  , wid / 4, hei)];
    [self.gradeLable setFont:font];
    [self.gradeLable setTextColor:[UIColor whiteColor]];
    [self addSubview:self.gradeLable];
    
    UILabel *p = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2, hei * 2, wid / 4, hei)];
    [p setTextColor:[UIColor whiteColor]];
    [p setFont:font];
    [p setText:@"PM25"];
    [self addSubview:p];
    [p release];
    
    self.PM25 = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3,hei * 2 , wid / 4, hei)];
    [self.PM25 setFont:font];
    [self.PM25 setTextColor:[UIColor whiteColor]];
    [self addSubview:self.PM25];
    
    
    UILabel *s = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2, hei * 3, wid / 4, hei)];
    [s setTextColor:[UIColor whiteColor]];
    [s setFont:font];
    [s setText:@"湿度"];
    [self addSubview:s];
    [s release];
    
    
    self.sk_sd = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3,hei * 3, wid / 4, hei)];
    [self.sk_sd setFont:font];
    [self.sk_sd setTextColor:[UIColor whiteColor]];
    [self addSubview:self.sk_sd];
}

- (void)drawRect:(CGRect)rect
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height / 5;
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat lengths[] = {1,1};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextSetRGBStrokeColor(context, 135.0 / 255.0 , 206.0 / 255.0, 235.0 / 255.0, 1);//线条颜色

    CGContextMoveToPoint(context, wid / 2,hei * 2);
    CGContextAddLineToPoint(context,wid - 20, hei * 2);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, wid / 2,hei * 3);
    CGContextAddLineToPoint(context,wid - 20, hei * 3);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, wid / 2,hei * 4);
    CGContextAddLineToPoint(context,wid - 20, hei * 4);
    CGContextStrokePath(context);

}

@end
