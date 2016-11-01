//
//  Photots.m
//  The_news
//
//  Created by 王&甄 on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Photots.h"
#import "photoDetails.h"
@implementation Photots

+ (instancetype)photoSetWith:(NSDictionary *)dict
{
    Photots *photoSet = [[Photots alloc]init];
    [photoSet setValuesForKeysWithDictionary:dict];
    
    NSArray *photoArray = photoSet.photos;
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:photoArray.count];
    
    for (NSDictionary *dict in photoArray) {
        photoDetails *photoModel = [photoDetails photoDetailWithDict:dict];
        [temArray addObject:photoModel];
    }
    photoSet.photos = temArray;
    
    return photoSet;
}



@end
