//
//  DrawView.m
//  ExploreWorld
//
//  Created by dlios on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DrawView.h"
#import "WeatherModel.h"
@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGContextSetLineWidth(context, 1);//设置画笔宽度
    CGContextSetFillColorWithColor(context, [[self backgroundColor] CGColor]);  //设置背景填充颜色
    CGContextFillRect(context, rect);                                           //填充背景
    //arr 为实时获取的动态数据数组
    for (int i = 0; i < _arr.count; i ++) {
        if (i < _arr.count - 1) {
            WeatherModel *now =  self.arr[i];
            WeatherModel *next = self.arr[i + 1];
            CGContextMoveToPoint(context, now.X, now.Y);
            CGContextAddLineToPoint(context, next.X , next.Y);
            CGContextStrokePath(context);
        }
    }
}

@end
