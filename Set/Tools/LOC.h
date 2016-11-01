//
//  LOC.h
//  The_news
//
//  Created by dlios on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOC : NSObject
+ (void)writeLoc:(NSString *)locCity;
+ (NSString*)readLoc;
@end
