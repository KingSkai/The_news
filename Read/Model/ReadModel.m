//
//  ReadModel.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

- (void)dealloc
{
    [_title release];
    [_feature_img release];
    [_created_at release];
    [_replies_count release];
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 通过自定义初始化, 封装KVC赋值方法
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

#pragma mark - 便利构造器
+ (instancetype)baseModelWithDic:(NSDictionary *)dic
{
    // 当前类调用初始化  返回值为任意类型
    id objc = [[[[self class] alloc] initWithDic:dic] autorelease];
    return objc;
}

#pragma mark - 转化方法 数组套字典 转化为 数组套model
+ (NSMutableArray *)arraryWithModelByArray:(NSArray *)arr
{
    // 创建一个可变数组 保存model并返回结果
    NSMutableArray *arr1 = [NSMutableArray array];
    
    // 遍历参数数组
    for (NSDictionary *dic in arr) {
        // 自动释放池 - 用于释放 autorelease
        @autoreleasepool {
            // 创建对象
            id model = [[self class] baseModelWithDic:dic];
            // 添加数组
            [arr1 addObject:model];
        }
    }
    return arr1;
}


// KVC 赋值容错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //如果K找不到 则什么都不赋值
}

@end
