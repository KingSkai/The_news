//
//  WeatherModel.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 wk. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

- (void)dealloc
{
    [self.date release];
    [self.tz release];
    [self.aqi release];
    [self.grade release];
    [self.wd release];
    [self.ws release];
    [self.mph release];
    [self.kph release];
    [self.fl release];
    [self.fl_f release];
    [self.rh release];
    [self.p_mb release];
    [self.pt release];
    [self.h release];
    [self.sr release];
    [self.ss release];
    [self.pm25 release];
    [self.so2 release];
    [self.no2 release];
    [self.sk_sd release];
    [self.sk_fx release];
    [self.sk_fl release];
    [self.temp_date release];
    [self.temp_day_tq release];
    [self.temp_day_tq_img release];
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@",key);
}

@end
