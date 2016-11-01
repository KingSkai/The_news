//
//  WeatherModel.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

#pragma mark - 从“天气预报”抓取的接口

//未来天的model------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic,copy)NSString *date;    //天气事件        2015-07-14
@property (nonatomic,copy)NSString *tz;      //              Asia/Shanghai
@property (nonatomic,copy)NSString *d;       //周几            2
@property (nonatomic,copy)NSString *aqi;     //空气污染指数      55
@property (nonatomic,copy)NSString *grade;   //评级           良好
@property (nonatomic,copy)NSString *tn;      //               32;
@property (nonatomic,retain)NSNumber *tn_f;    //               89;
@property (nonatomic,retain)NSNumber *tl;       //当前天最低气温   23；
@property (nonatomic,retain)NSNumber *tl_f;    //                73;
@property (nonatomic,retain)NSNumber *th;      //当前天最高气温    33；
@property (nonatomic,retain)NSNumber *th_f;     //                91;
@property (nonatomic,retain)NSMutableArray *wd;    //[1],
@property (nonatomic,retain)NSMutableArray *ws;  //[2],
@property (nonatomic,copy)NSString *kph;        //风速      6~11（千米/小时）
@property (nonatomic,copy)NSString *mph;        //风速    3.7~6.8 (英里/小时，1mph= 0.44704m/s)
@property (nonatomic,copy)NSString *fl_f;       //               92;
@property (nonatomic,copy)NSString *fl;         //               33;
@property (nonatomic,copy)NSString *rh;          //                38;
@property (nonatomic,copy)NSString *p_mb;       //         1003;
@property (nonatomic,copy)NSString *pt;        //                0;
//未来小时的model-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic,copy)NSString *h;        //具体的小时      11;
@property (nonatomic,assign)NSString *tm;     //当前小时的气温    33
//未来小时的model-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic,copy)NSString *sr;        //日出时间     04:39；
@property (nonatomic,copy)NSString *ss;      //日落时间      19:19
@property (nonatomic,copy)NSString *pm25;    // pm25         20;
@property (nonatomic,copy)NSString *so2;      // so2     10;
@property (nonatomic,copy)NSString *no2;      //no2     39;
//未来小时的点的坐标-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic,assign)float X;
@property (nonatomic,assign)float Y;
#pragma mark - 从“中国天气”抓取的接口
@property (nonatomic,copy)NSString *sk_sd;        //湿度   28%
@property (nonatomic,copy)NSString *sk_fx;        //风向   东北风
@property (nonatomic,copy)NSString *sk_fl;        //风力    2级
@property (nonatomic,copy)NSString *temp_day_tq;    //天气状况      晴转多云
@property (nonatomic,copy)NSString *temp_day_tq_img;     //天气图片代码     00
@property (nonatomic,copy)NSString *temp_date;     //日期 2015年07月15日星期三
@end
