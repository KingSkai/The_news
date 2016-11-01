//
//  WindView.m
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "WindView.h"

@implementation WindView

- (void)dealloc
{
    [self.pile release];
    [self.leaf release];
    [self.sk_fl release];
    [self.sk_fs release];
    [self.sk_fx release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMyWindView];
    }
    return self;
}


- (void)createMyWindView
{
    float wid = self.frame.size.width;
    float hei = self.frame.size.height / 6;
    UIFont *font = [UIFont systemFontOfSize:12];
    float height = self.frame.size.height / 5;

    UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, wid - 10, hei)];
    [t setTextColor:[UIColor whiteColor]];
    [t setFont:[UIFont systemFontOfSize:14]];
    [t setText:@"风力详情"];
    [self addSubview:t];
    [t release];
    
#pragma mark -
#pragma mark 第一组
    //风扇桩
    self.pile = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, hei * 3)];
    [self.pile setCenter:CGPointMake(wid / 8, hei * 4.5)];
    [self.pile setImage:[UIImage imageNamed:@"bigpole@3x.png"]];
    [self addSubview:self.pile];
    
    //风扇叶
    self.leaf = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, hei * 3, hei * 3)];
    [self.leaf setCenter:CGPointMake(wid / 8, hei * 3)];
    [self.leaf setImage:[UIImage imageNamed:@"blade_big_blur@3x.png"]];
    
    [self addSubview:self.leaf];
    
    [self performSelector:@selector(AddAnimationForLeaf:) withObject:self.leaf afterDelay:0.5];
    
#pragma mark -
#pragma mark 第二组
    
    UIImageView *pil = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5 , hei * 1.5)];
    [pil setCenter:CGPointMake(wid / 4, hei * 5.25)];
    [pil setImage:[UIImage imageNamed:@"bigpole@3x.png"]];
    [self addSubview:pil];
    
    
    UIImageView *lea = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, hei * 1.5, hei * 1.5)];
    [lea setCenter:CGPointMake(wid / 4, hei * 4.5)];
    [lea setImage:[UIImage imageNamed:@"blade_big_blur@3x.png"]];
    [self addSubview:lea];
    [self performSelector:@selector(AddAnimationForLeaf:) withObject:lea afterDelay:0.5];
    
   
    
     //风力
    UILabel *fl = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2,height, wid / 4, height)];
    [fl setText:@"风力"];
    [fl setTextColor:[UIColor whiteColor]];
    [fl setFont:font];
    [self addSubview:fl];
    [fl release];
    
    self.sk_fl = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3 ,height, wid / 4, height)];
    [self addSubview:self.sk_fl];
    [self.sk_fl setFont:font];
    [self.sk_fl setTextColor:[UIColor whiteColor]];
    
    //风向
    UILabel *fx = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2, height * 2, wid / 4, height)];
    [fx setFont:font];
    [fx setTextColor:[UIColor whiteColor]];
    [self addSubview:fx];
    [fx setText:@"方向"];
    [fx release];
    
    self.sk_fx = [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3, height * 2, wid / 4, height )];
    [self addSubview: self.sk_fx];
    [self.sk_fx setFont:[UIFont systemFontOfSize:12]];
    [self.sk_fx setTextColor:[UIColor whiteColor]];
    
    //风速
    UILabel *fs = [[UILabel alloc]initWithFrame:CGRectMake(wid / 2,height * 3, wid / 4 * 3, height)];
    [fs setFont:font];
    [fs setTextColor:[UIColor whiteColor]];
    [self addSubview:fs];
    [fs setText:@"风速"];
    [fs release];
    
    self.sk_fs =  [[UILabel alloc]initWithFrame:CGRectMake(wid / 4 * 3, height * 3, wid / 4, height )];
    [self addSubview:self.sk_fs];
    [self .sk_fs setFont:[UIFont systemFontOfSize:12]];
    [self.sk_fs setTextColor:[UIColor whiteColor]];
}

//为枫叶添加旋转动画
- (void)AddAnimationForLeaf:(UIView * )leafView
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    theAnimation.duration = 1;
    theAnimation.repeatCount = 1000000000;
    theAnimation.removedOnCompletion = YES;
    theAnimation.cumulative = NO;
    [leafView.layer addAnimation:theAnimation forKey:@"animateTransform"];
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
