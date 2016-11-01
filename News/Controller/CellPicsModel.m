//
//  CellPicsModel.m
//  The_news
//
//  Created by 王&甄 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "CellPicsModel.h"

@implementation CellPicsModel
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    CellPicsModel *img = [[self alloc]init];
    img.ref = dict[@"ref"];
    img.pixel = dict[@"pixel"];
    img.src = dict[@"src"];
    
    return img;
}

@end
