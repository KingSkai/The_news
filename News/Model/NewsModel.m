//
//  NewsModel.m
//  天下事
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
+ (instancetype)newsModelwithDic:(NSDictionary *)dic{
    NewsModel *modle = [[self alloc]init];
    [modle setValuesForKeysWithDictionary:dic];
    return modle;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
