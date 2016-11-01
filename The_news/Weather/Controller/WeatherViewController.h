//
//  WeatherViewController.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 wk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LittleUILable.h"
#import "Hourly_forecastUILable.h"
#import "WindView.h"
#import "WeatherDetailView.h"
#import "NowTemLable.h"

@interface WeatherViewController : UIViewController

//从“天气预报”抓的接口的数据存放的数组

@property  (nonatomic,retain)NSMutableArray *forecastArray;



//创建底层的scrollView
@property (nonatomic,retain)UIScrollView *bgScroll;

//未来36小时的滚动视图
@property (nonatomic,retain)UIScrollView *Hourly_forecast;
@property (nonatomic,retain)NSMutableArray *hourly_forecastArray;

//存放未来36小时气温的点所应在坐标
@property (nonatomic,retain)NSMutableArray *hourly_temperatureArray;

@property (nonatomic,retain)NSMutableArray *point;






//未来7天的天气预报
@property (nonatomic,retain)UIScrollView *forecast;


@property (nonatomic,retain)NSMutableArray *aqiArray;


//从“中国天气”抓的接口的数据存放的数组
@property (nonatomic,retain)NSMutableArray *ChinaArray;

@property (nonatomic,retain)NSMutableArray *sun_phaseArray;

@property(nonatomic,strong)CALayer *myLayer;

//----------------------
@property (nonatomic,retain)LittleUILable *weather;
@property (nonatomic,retain)LittleUILable *PM25;
@property (nonatomic,retain)LittleUILable *grade;
@property (nonatomic,retain) Hourly_forecastUILable *lable;

@property (nonatomic,retain) WindView *wind ;
@property (nonatomic,retain)WeatherDetailView *detailView;


@property (nonatomic,retain)UIImageView *BGView;

@property (nonatomic,retain)NowTemLable *nowTem ;
@property (nonatomic,retain) UIImageView *sun_ani;



 @end
