//
//  ReadModel.h
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *feature_img;
@property (nonatomic, retain) NSString *feed_id;
@property (nonatomic, retain) NSString *replies_count;
@property (nonatomic, retain) NSString *created_at;

// 收藏点击响应
@property (nonatomic,assign) BOOL collectioned; // 是否收藏

- (instancetype)initWithDic:(NSDictionary *)dic;

// 遍历构造器
+ (instancetype)baseModelWithDic:(NSDictionary *)dic;

// 转化方法 数组套字典 转化为数组套model
+ (NSMutableArray *)arraryWithModelByArray:(NSArray *)arr;
@end
