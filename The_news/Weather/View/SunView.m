//
//  SunView.m
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "SunView.h"
@implementation SunView

-  (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSSAndSrLable];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float hei = self.frame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置填充颜色
    UIColor *col = [UIColor colorWithRed:135.0 / 255.0 green:206.0 / 255.0 blue:235.0 / 255.0 alpha:1];
    CGContextSetFillColorWithColor(context,col.CGColor);
    
    //以100为半径,(150，150)围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 120, hei  - 20  ); //圆弧起点坐标
    CGContextAddArc(context, 120,  hei - 20, 100,  180 * M_PI / 180, 0 * M_PI / 180, 0);
    CGContextClosePath(context);
    CGContextSetRGBStrokeColor(context, 135.0 / 255.0 , 206.0 / 255.0, 235.0 / 255.0, 1);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
}

- (void)dealloc
{
    [self.ssLable release];
    [self.srLable release];
    [super dealloc];
}



- (void)createSSAndSrLable
{
    float hei = self.frame.size.height;
    float wei = self.frame.size.width;
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, wei - 10, 30)];
    [la setText:@"太阳升落"];
    [la setTextColor:[UIColor whiteColor]];
    [la  setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:la];
    [la release];
    
    self.ssLable = [[UILabel alloc]initWithFrame:CGRectMake(20, hei - 20, 30, 20)];
    [self.ssLable setTextColor:[UIColor whiteColor]];
    [self.ssLable setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:self.ssLable];
    
    
    self.srLable = [[UILabel alloc]initWithFrame:CGRectMake(190, hei - 20, 30, 20)];
    [self.srLable setTextColor:[UIColor blackColor]];
    [self.srLable setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:self.srLable];
}


@end
