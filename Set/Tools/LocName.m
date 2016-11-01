//
//  LocName.m
//  The_news
//
//  Created by 王凯 on 15/7/31.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "LocName.h"

@implementation LocName


// 简单对象分别是 NSString  NSArray  NSData  NSDictionary

// 所有的存储,必须先知道要存得地方
+ (void)writeLoc:(NSString *)locCity
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    path = [NSString stringWithFormat:@"%@/%@",path,@"locName.txt"];
    NSLog(@"%@",path);
    // 存储
    NSError *error = nil;
    
    BOOL judge = [locCity writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (judge) {
        NSLog(@"存储成功");
    }else {
        NSLog(@"存储失败");
    }
}

// 读取文件
+ (NSString*)readLoc
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    path = [NSString stringWithFormat:@"%@/%@",path,@"locName.txt"];
    NSLog(@"%@",path);
    
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
    
    
}

@end
