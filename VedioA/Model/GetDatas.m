//
//  GetDatas.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "GetDatas.h"
#import "AFNetworking.h"

@implementation GetDatas
+(void)getDataWith:(NSString *)url completion:(void(^)(id result))block{
    NSString *urll = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    [manger GET:urll parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            block(result);
        }else{
            NSLog(@"no data");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"no data");
    }];
}

@end
