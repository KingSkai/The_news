//
//  DataHandel.m
//  天下事
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DataHandel.h"

@implementation DataHandel

+(void)GetDataWithURLstr:(NSString *)urlstr complete:(void (^)(id result))block{
    NSString *str = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manger  =[AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            block(result);
        }else{
            NSLog(@"no data");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
}

@end
