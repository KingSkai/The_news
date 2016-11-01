//
//  CollectModel.h
//  The_news
//
//  Created by dlios on 15/7/18.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject

@property (nonatomic,copy)NSString *ima;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *mediaUrl;

// 阅读 - 公用 ima title
// 判断 使用字符串判断是否为阅读
@property (nonatomic, retain) NSString *read;
@property (nonatomic, retain) NSString *feed_id;


@end
