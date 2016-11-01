//
//  CollectModel.m
//  The_news
//
//  Created by dlios on 15/7/18.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel


- (void)dealloc
{
    [self.ima release];//图片地址
    [self.title release]; //新闻标题
    [self.mediaUrl release];//视屏地址
    [self.url release];//新闻地址
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
