//
//  Photots.h
//  The_news
//
//  Created by 王&甄 on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photots : NSObject
@property (nonatomic, copy) NSString *postid;
@property (nonatomic, copy) NSString *series;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *datatime;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *relatedids;
@property (nonatomic, copy) NSString *scover;
@property (nonatomic, copy) NSString *autoid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, copy) NSString *reporter;
@property (nonatomic, copy) NSString *setname;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *commenturl;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *settag;
@property (nonatomic, copy) NSString *boardid;
@property (nonatomic, copy) NSString *tcover;
@property (nonatomic, copy) NSNumber *imgsum;
+ (instancetype)photoSetWith:(NSDictionary *)dict;

@end
