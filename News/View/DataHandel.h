//
//  DataHandel.h
//  天下事
//
//  Created by dlios on 15-7-13.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DataHandel : NSObject

+(void)GetDataWithURLstr:(NSString *)urlstr complete:(void (^)(id result))block;

@end
