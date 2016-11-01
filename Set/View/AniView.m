//
//  AniView.m
//  The_news
//
//  Created by 王凯 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "AniView.h"
#import <QuartzCore/QuartzCore.h>


@implementation AniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint=[[touches anyObject]locationInView:self];
    CALayer *waveLayer=[CALayer layer];
    waveLayer.frame = CGRectMake(touchPoint.x - 1, touchPoint.y - 1, 10, 10);
    int colorInt = arc4random() % 7;
    switch (colorInt) {
        case 0:
            waveLayer.borderColor =[UIColor redColor].CGColor;
            break;
        case 1:
            waveLayer.borderColor =[UIColor grayColor].CGColor;
            break;
        case 2:
            waveLayer.borderColor =[UIColor purpleColor].CGColor;
            break;
        case 3:
            waveLayer.borderColor =[UIColor orangeColor].CGColor;
            break;
        case 4:
            waveLayer.borderColor =[UIColor yellowColor].CGColor;
            break;
        case 5:
            waveLayer.borderColor =[UIColor greenColor].CGColor;
            break;
        case 6:
            waveLayer.borderColor =[UIColor blueColor].CGColor;
            break;
        default:
            waveLayer.borderColor =[UIColor blackColor].CGColor;
            break;
    }
    waveLayer.borderWidth = 0.8;
    waveLayer.cornerRadius = 5.0;
    [self.layer addSublayer:waveLayer];
    [self scaleBegin:waveLayer];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint=[[touches anyObject]locationInView:self];
    CALayer *waveLayer=[CALayer layer];
    waveLayer.frame = CGRectMake(touchPoint.x - 1, touchPoint.y - 1, 10, 10);
    int colorInt=arc4random() % 7;
    switch (colorInt) {
        case 0:
            waveLayer.borderColor =[UIColor redColor].CGColor;
            break;
        case 1:
            waveLayer.borderColor =[UIColor grayColor].CGColor;
            break;
        case 2:
            waveLayer.borderColor =[UIColor purpleColor].CGColor;
            break;
        case 3:
            waveLayer.borderColor =[UIColor orangeColor].CGColor;
            break;
        case 4:
            waveLayer.borderColor =[UIColor yellowColor].CGColor;
            break;
        case 5:
            waveLayer.borderColor =[UIColor greenColor].CGColor;
            break;
        case 6:
            waveLayer.borderColor =[UIColor blueColor].CGColor;
            break;
        default:
            waveLayer.borderColor =[UIColor blackColor].CGColor;
            break;
    }
    waveLayer.borderWidth = 1;
    waveLayer.cornerRadius = 5.0;
    
    [self.layer addSublayer:waveLayer];
    [self scaleBegin:waveLayer];
}

-(void)scaleBegin:(CALayer *)aLayer
{
    // 比例 原120
    const float maxScale = 5.0;
    if (aLayer.transform.m11 < maxScale) {
        if (aLayer.transform.m11 == 1.0) {
            [aLayer setTransform:CATransform3DMakeScale( 1.1, 1.1, 0.5)];
            
        }else{
            [aLayer setTransform:CATransform3DScale(aLayer.transform, 1.1, 1.1, 0.5)];
        }
        [self performSelector:_cmd withObject:aLayer afterDelay:0.08];
    }else [aLayer removeFromSuperlayer];
}


@end
