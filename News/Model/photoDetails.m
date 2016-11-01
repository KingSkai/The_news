//
//  photoDetails.m
//  The_news
//
//  Created by 王&甄 on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "photoDetails.h"

@implementation photoDetails

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    photoDetails *photoDetail = [[photoDetails alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    
    return photoDetail;
}


@end
