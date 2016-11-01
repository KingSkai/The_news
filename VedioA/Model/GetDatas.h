//
//  GetDatas.h
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDatas : NSObject
+(void)getDataWith:(NSString *)url completion:(void(^)(id result))block;

@end
