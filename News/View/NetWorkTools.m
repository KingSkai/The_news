//
//  NetWorkTools.m
//  天下事
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools
//创建单例
+(instancetype)sharNetworkTools{
    static NetWorkTools*instance;
    static dispatch_once_t onceToken;
    //保证block块的代码被执行一次
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    });
//    NSLog(@"%@", instance);
    return instance;

}



@end
