//
//  AFNetworking_Read.h
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworking_Read : NSObject

+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void(^)(id result))block;

@end
