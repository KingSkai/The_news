//
//  ListenModel.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListenModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *guid;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *itemId;
@property (nonatomic,copy)NSString *video;
@property (nonatomic,copy)NSString *memberId;
@property (nonatomic,copy)NSString *playTime;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *memberIds;
@property (nonatomic,copy)NSString *mediaUrl;
@property (nonatomic,copy)NSString *videoID;
@property (nonatomic,assign) BOOL collectioned; // 是否收藏
@end
