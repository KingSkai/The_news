//
//  CelldetailsModel.m
//  The_news
//
//  Created by 王&甄 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "CelldetailsModel.h"
#import "CellPicsModel.h"
@implementation CelldetailsModel
+ (instancetype)cellDetailsWithdic:(NSDictionary *)dic{
    CelldetailsModel *cellM = [[self alloc]init];
    cellM.title = dic[@"title"];
    cellM.ptime = dic[@"ptime"];
    cellM.body = dic[@"body"];
    NSArray *imgArr = dic[@"img"];
    NSMutableArray *temarr = [NSMutableArray array];
    for (NSDictionary *dic in imgArr) {
        CellPicsModel *img = [CellPicsModel detailImgWithDict:dic];
        [temarr addObject:img];
    }
    cellM.img = temarr;
    return cellM;


}
@end
