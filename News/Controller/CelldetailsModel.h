//
//  CelldetailsModel.h
//  The_news
//
//  Created by 王&甄 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CelldetailsModel : NSObject
// 新闻标题
@property (nonatomic, copy) NSString *title;
// 新闻发布时间
@property (nonatomic, copy) NSString *ptime;
// 新闻内容
@property (nonatomic, copy) NSString *body;
//新闻配图
@property (nonatomic, strong) NSArray *img;

+(instancetype)cellDetailsWithdic:(NSDictionary *)dic;


@end
