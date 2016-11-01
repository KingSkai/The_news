//
//  TenHeaderLable.m
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TenHeaderLable.h"

@implementation TenHeaderLable
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        self.scale = 0.0;
    }
    return self;
}
//通过scale改变参数
- (void)setScale:(CGFloat)scale{
    _scale = scale;
    
  //  self.textColor = [UIColor colorWithRed:211 / 255 green:211 / 255 blue:211 / 255 alpha:scale];
    self.textColor = [UIColor blackColor];
    [self.layer setBorderColor:[[UIColor colorWithRed:19 / 255.0 green:158 / 255.0 blue:238 / 255.0 alpha:1] CGColor]];
    [self.layer setCornerRadius:5];
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1 - minScale) * scale;
    // 不改变中心点
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
