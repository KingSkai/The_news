//
//  ListenModel.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ListenModel.h"

@implementation ListenModel
- (void)dealloc
{
    [_title release];
    [_image release];
    [_guid release];
    [_createDate release];
    [_duration release];
    [_itemId release];
    [_memberId release];
    [_playTime release];
    [_itemId release];
    [_memberIds release];
    [_ID release];
    [_mediaUrl release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
