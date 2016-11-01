//
//  DrawLineView.m
//  The_news
//
//  Created by dlios on 15/7/27.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView

- (void)drawRect:(CGRect)rect{
   
    float hei = self.frame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置填充颜色
     CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);

    CGFloat lengths[] = {1,1};
    CGContextSetLineDash(context, 0, lengths, 2);
    //以100为半径,(150，150)围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 20, hei  - 20  ); //圆弧起点坐标
    CGContextAddArc(context, 120,  hei - 20, 100,  180 * M_PI / 180, 0 * M_PI / 180, 0);
   // CGContextClosePath(context);
    CGContextSetRGBStrokeColor(context, 135.0 / 255.0 , 206.0 / 255.0, 235.0 / 255.0, 1);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    
}
@end
