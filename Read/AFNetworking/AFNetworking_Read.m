//
//  AFNetworking_Read.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "AFNetworking_Read.h"
#import "AFNetworking.h"

@implementation AFNetworking_Read

+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void (^)(id))block
{
    
//    UIMenuController
    
    
    // 网址的转码 处理中文字符
    NSString *str = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 创建AFN网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置响应解析对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置数据支持类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    
    // AFNGET请求
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 请求成功执行的地方
        // responseObject返回数据位NSData
        if (responseObject) {
            // 如果返回数据不为空 则开始JSON解析
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            // 通过block数据回调
            block(result);
        } else {
            NSLog(@"打印数据为空 请检查");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求失败执行的地方
    }];
}



@end
