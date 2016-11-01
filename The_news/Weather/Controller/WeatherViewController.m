//
//  WeatherViewController.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 wk. All rights reserved.

#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "Header.h"
#import "NowTemLable.h"
//未来几天的天气
#import "ForecastUILable.h"
#import "DrawView.h"
#import "DrawLineView.h"
#import "WindView.h"
//日出日落
#import "SunView.h"
#import "WeatherHeader.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)dealloc
{
    [self.bgScroll release];
    [self.Hourly_forecast release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.forecastArray = [NSMutableArray array];
        self.hourly_forecastArray = [NSMutableArray array];
        self.hourly_temperatureArray = [NSMutableArray array];
        self.point = [NSMutableArray array];
        self.aqiArray = [NSMutableArray array];
        self.ChinaArray = [NSMutableArray array];
        self.sun_phaseArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self weatherNetRequestWithCityName:[LOC readLoc]];
}

#pragma mark -
#pragma mark 隐藏掉状态栏
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.BGView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.BGView setImage:[UIImage imageNamed:@"weather_bg.jpg"]];
    
    [self.view addSubview:self.BGView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createWeatherView];
    [self createWeatherDetailView];
    [self createHourly_forecastScroll];
    [self createforecastScroll];
    [self createWindView];
}

#pragma mark -
#pragma mark 传入定位定到的城市名称，对citys.plist文件进行便利，查找出与城市名字对应的城市cityid，取出来做网址参数进行网络请求

- (void)weatherNetRequestWithCityName:(NSString *)cityName
{
    //对plist文件进行解析
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"plist"];
    NSMutableArray *cityArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    for (NSMutableDictionary *cityDic in cityArray) {
        NSString *str = [cityDic objectForKey:@"cityname"];
        if ([str isEqualToString:cityName]) {
            [self  netConnectFromWeatherForcastWithCityID:[cityDic objectForKey:@"cityid"]];
        }
    }
}

#pragma mark -
#pragma mark 从天气预报抓的接口的网络请求

-(void)netConnectFromWeatherForcastWithCityID:(NSString *)cityID
{
    //对未来几天进行网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    NSString *str = [NSString stringWithFormat:@"http://weather.ios.ijinshan.com/api/forecasts?cc=w-%@",cityID] ;
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        //超大字典
        NSDictionary *BigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //解析未来几天的天气数据，从这个字典里拿出未来几天的数据，存放到forecast数组里
        NSMutableDictionary *Dic = [BigDic objectForKeyedSubscript:@"forecast"];
        NSMutableArray *Array = [Dic objectForKey:[NSString stringWithFormat:@"w-%@",cityID]];
        for (NSMutableDictionary *dic in Array) {
            
            WeatherModel *model = [[WeatherModel alloc]init];
            model.date = [dic objectForKey:@"date"];
            model.tz = [dic objectForKey:@"tz"];
            model.d = [dic objectForKey:@"d"];
            model.aqi = [dic objectForKey:@"aqi"];
            model.grade = [dic objectForKey:@"grade"];
            model.tn = [dic objectForKey:@"tn"];
            model.tn_f = [dic objectForKey:@"tn_f"];
            model.tl = [dic objectForKey:@"tl"];
            model.tl_f = [dic objectForKey:@"tl_f"];
            model.th = [dic objectForKey:@"th"];
            model.th_f = [dic objectForKey:@"th_f"];
            NSMutableArray *wd = [dic objectForKey:@"wd"];
            model.wd = wd[0];
            NSMutableArray *ws = [dic objectForKey:@"ws"];
            model.ws = ws[0];
            NSMutableArray *kph = [dic objectForKey:@"kph"];
            model.kph =  kph[0];
            NSMutableArray *mph = [dic objectForKey:@"mph"];
            model.mph = mph[0];
            model.fl_f = [dic objectForKey:@"fl_f"];
            model.fl = [dic objectForKey:@"fl"];
            model.rh = [dic objectForKey:@"rh"];
            model.p_mb = [dic objectForKey:@"p_mb"];
            model.pt = [dic objectForKey:@"pt"];
            [ self.forecastArray addObject:model];
            
        }
        //解析未来36小时的数据，从这个字典里拿出未来36小时的数据，存放到forecast数组里
        NSMutableDictionary *secondDic = [BigDic objectForKey:@"hourly_forecast"];
        NSMutableArray *bigArray = [secondDic objectForKey:[NSString stringWithFormat:@"w-%@",cityID]];
        for (NSMutableDictionary *dic in bigArray) {
            WeatherModel *model = [[WeatherModel alloc]init];
            model.h = [dic objectForKey:@"h"];
            NSMutableArray *kphArray = [dic objectForKey:@"kph"];
            model.kph = kphArray[0];
            model.tm = [dic objectForKey:@"tm"];
            [self.hourly_forecastArray addObject:model];
            [self.hourly_temperatureArray addObject:model.tm];
        }
        
        //实时天气具体
        NSMutableDictionary *aqi = [BigDic objectForKey:@"aqi"];
        NSMutableDictionary *locDic = [aqi objectForKey:[NSString stringWithFormat:@"w-%@",cityID]];
        WeatherModel *AQI = [[WeatherModel alloc]init];
        AQI.aqi = [locDic objectForKey:@"aqi"];
        AQI.pm25 = [locDic objectForKey:@"pm25"];
        AQI.grade = [locDic objectForKey:@"grade"];
        [self.aqiArray addObject:AQI];
        
        //解析出日出日落时间
        NSMutableDictionary *podic = [BigDic objectForKey:@"sun_phase"];
        NSMutableDictionary *opDic = [podic objectForKey:[NSString stringWithFormat:@"w-%@",cityID]];
        // NSMutableDictionary *td = [opDic objectForKey:@"td"];
        NSMutableDictionary *td = [opDic objectForKey:@"td"];
        WeatherModel *SUN = [[WeatherModel alloc]init];
        SUN.ss = [td objectForKey:@"ss"];
        SUN.sr = [td objectForKey:@"sr"];
        [self.sun_phaseArray addObject:SUN];
        [self createHourly_forecastLable];
        [self createSunView];
        
        //对未来几天进行网络请求
        AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
        manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
        [ manager1.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
        NSString *str1 = [NSString stringWithFormat:@"http://chinaweather.cloudapp.net/Default.aspx?city=%@&id=955d8868-a276-4425-aef6-32077b1006d0",cityID] ;
        [manager GET:str1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = operation.responseData;
            //超大字典
            NSDictionary *BigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (int i = 1;i <= 7  ; i ++) {
                for (NSString *key in BigDic) {
                    
                    NSString *str = [NSString stringWithFormat:@"temp%d",i];
                    if ([key rangeOfString:str].location != NSNotFound) {
                        NSString *temp_day_tq = [NSString stringWithFormat:@"%@_day_tq",str];
                        NSString *temp_day_tq_img = [NSString stringWithFormat:@"%@_day_tq_img",str];
                        NSString *temp_date = [NSString stringWithFormat:@"%@_date",str];
                        WeatherModel *model = [[WeatherModel alloc]init];
                        model.sk_sd = [BigDic objectForKey:@"sk_sd"];
                        model.sk_fx = [BigDic objectForKey:@"sk_fx"];
                        model.sk_fl = [BigDic objectForKey:@"sk_fl"];
                        model.temp_day_tq = [BigDic objectForKey:temp_day_tq];
                        model.temp_day_tq_img = [BigDic objectForKey:temp_day_tq_img];
                        model.temp_date = [BigDic objectForKey:temp_date];
                        [self.ChinaArray addObject:model];
                        break;
                    }
                }
            }
            [self createforecastLable];
            [self loadViewDate];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark -
#pragma mark 创建天气界面
- (void)createWeatherView
{
    self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT )];
    [self.bgScroll setContentSize:CGSizeMake(0,HEIGHT + WIDTH * 2 + 240)];
    [self.bgScroll setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.bgScroll];
    
    //城市名称
    UILabel *city = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [city setCenter:CGPointMake(WIDTH / 2, 20)];
    [city setTextAlignment:NSTextAlignmentCenter];
    [city setFont:[UIFont systemFontOfSize:20]];
    [city setTextColor:[UIColor whiteColor]];
    [city setText:[LOC readLoc]];
    [self.BGView addSubview:city];
    [city release];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(40, 10, 20, 20)];
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back release];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - WIDTH / 2, 100, 40)];
    [lable setText:@"风力气温波动"];
    [lable setFont:[UIFont systemFontOfSize:14]];
    [self.bgScroll addSubview:lable];
    [lable setAlpha:0.8];
    [lable setTextColor:[UIColor grayColor]];
    [lable release];
    
    self.nowTem = [[NowTemLable alloc]initWithFrame:CGRectMake(0, 80, 200, 140)];
    [self.bgScroll addSubview:self.nowTem];
    [self.nowTem release];
    
    self.weather = [[[LittleUILable alloc]initWithFrame:CGRectMake(30, 220, 200, 30)]autorelease];
    [self.bgScroll addSubview:self.weather];
    
    
    self.PM25 = [[[LittleUILable alloc]initWithFrame:CGRectMake(30, 255, 200, 30)]autorelease];
    [self.PM25.ima setImage:[UIImage imageNamed:@"pm25.png"]];
    [self.bgScroll addSubview:self.PM25];
    
    
    self.grade = [[[LittleUILable alloc]initWithFrame:CGRectMake(30, 290, 200, 30)]autorelease];
    [self.bgScroll addSubview:self.grade];
    [self.grade.ima setImage:[UIImage imageNamed:@"grade.png"]];
}

- (void)backClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark 加载数据
- (void)loadViewDate
{
    WeatherModel *china = self.ChinaArray[0];
    WeatherModel *model = self.aqiArray[0];
    WeatherModel *model2 = self.forecastArray[0];
    
    //风
    self.wind.sk_fx.text = china.sk_fx;
    self.wind.sk_fl.text = china.sk_fl;
    WeatherModel *forecast = self.forecastArray[0];
    self.wind.sk_fs.text = [self givekphReturnsk_fl:forecast.kph];
    
    //详细信息
    self.detailView.gradeLable.text = model.grade;
    self.detailView.PM25.text = model.pm25;
    [self.detailView.weatherImageView setImage:[self getTemp_day_tq:china.temp_day_tq]];
    [self.detailView.sk_sd setText:china.sk_sd];
    
    //上面小的
    [self.weather.ima setImage:[ self getTemp_day_tq:china.temp_day_tq]];
    [self.weather.titleLable setText:china.temp_day_tq];
    [self.PM25.titleLable setText:model.pm25];
    [self.grade.titleLable setText:model.grade];
    
    //今天的超大温度
    [self.nowTem.temLable setText:[NSString stringWithFormat:@"%@",model2.tn]];
    [self.BGView setImage:[self returnBG_ViewByTemp_day_tq:china.temp_day_tq]];
}

#pragma mark -
#pragma mark 创建未来36小时天气的滚动视图
- (void)createHourly_forecastScroll
{
    self.Hourly_forecast = [[UIScrollView alloc]initWithFrame:CGRectMake(10, HEIGHT - WIDTH / 2 + 40, WIDTH - 20, WIDTH / 2)];
    [self.Hourly_forecast setContentSize:CGSizeMake(36 * WIDTH / 8, 0)];
    self.Hourly_forecast.showsHorizontalScrollIndicator = NO;
    self.Hourly_forecast.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.Hourly_forecast setClipsToBounds:YES];
    [self.bgScroll addSubview:self.Hourly_forecast];
}

//把小时Lable添加到 self.Hourly_forecast 滚动视图上
- (void)createHourly_forecastLable
{
    //找出这个数组里最大气温和最小气温
    int maxTem = 0;
    int minTem = 100;
    for (int i = 0; i < self.hourly_temperatureArray.count; i ++) {
        NSString *str = self.hourly_temperatureArray[i];
        float x = [str floatValue];
        maxTem = maxTem > x ? maxTem :x;
        minTem = minTem < x ? minTem :x;
    }
    
    int  wencha = maxTem - minTem;
    for (int i = 0; i < 36; i ++) {
        Hourly_forecastUILable *lable = [[Hourly_forecastUILable alloc]initWithFrame:CGRectMake(WIDTH / 8 * i , 0, WIDTH / 8 , WIDTH / 2)];
        UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, lable.frame.size.width - 2 , lable.frame.size.height)]autorelease];
        [view setCenter:CGPointMake(lable.center.x  , lable.center.y)];
        [self.Hourly_forecast addSubview:view];
        [view setBackgroundColor:[UIColor grayColor]];
        [view setAlpha:0.2];
       
        WeatherModel *model  =  self.hourly_forecastArray[i];
        //给小时和风力lable赋值
        NSString *hour = [NSString stringWithFormat:@"%@时",model.h];
        lable.timeLable.text = hour;
        lable.windLable.text = model.kph;
        [lable.timeImageView setImage:[self isNight:hour ]];
        
        int nowTem = [model.tm intValue];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
        [imageView  setClipsToBounds:YES];
        imageView.layer.cornerRadius = 2;
        //折点图片颜色
        [imageView setBackgroundColor: [UIColor whiteColor]];
        [imageView setCenter:CGPointMake(lable.rangeLable.frame.size.width / 2,  2 * WIDTH / 7 * (maxTem - nowTem) / wencha) ];
        [lable.rangeLable addSubview:imageView];
        
        model.X =  imageView.frame.origin.x + WIDTH / 8 * i + 1;
        model.Y =   2 * WIDTH / 7 * (maxTem - nowTem) / wencha  + 3 * WIDTH / 14;
        [self.point addObject:model];
        [self.Hourly_forecast addSubview:lable];
    }
    DrawView *draw = [[DrawView alloc]init];
    draw.arr = [NSMutableArray array];
    [draw.arr addObjectsFromArray:self.point];
    [draw setFrame:CGRectMake(0,0 , 36 * WIDTH / 8, WIDTH / 2)];
    [draw setBackgroundColor:[UIColor clearColor]];
    [self.Hourly_forecast addSubview:draw];
}

//传入此时时间，判断是否是夜晚，返回白天或者夜晚的图片
- (UIImage *)isNight :(NSString *)hour
{
    float h = [hour floatValue];
    WeatherModel *model = self.sun_phaseArray[0];
    NSArray *second = [model.ss componentsSeparatedByString:@":"];
    NSArray *first = [model.sr componentsSeparatedByString:@":"];
    float firsth = [first[0] floatValue];
    float secondh = [second[0] floatValue];
    if (h > firsth && h < secondh) {
        return  [UIImage imageNamed: @"day.png"];
    } else
    {
        return  [UIImage imageNamed:@"night.png"];
    }
}

#pragma mark -
#pragma mark 未来10天的天气的滚动视图
- (void)createforecastScroll
{
    self.forecast = [[UIScrollView alloc]initWithFrame:CGRectMake(10, HEIGHT + 60, WIDTH - 20, WIDTH / 2)];
    [self.forecast  setContentSize:CGSizeMake(WIDTH / 6 * 10, 0)];
    [self.forecast setBackgroundColor:[UIColor grayColor]];
    self.forecast.showsHorizontalScrollIndicator = NO;
    [self.forecast setClipsToBounds:YES];
    self.forecast.layer.cornerRadius = 5;
    [self.forecast setAlpha:0.5];
    [self.bgScroll addSubview:self.forecast];
}

//创建未来几天的lable
- (void)createforecastLable
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
    for (int i = 0; i < self.forecastArray.count; i ++) {
        WeatherModel *model = self.forecastArray[i];
        ForecastUILable *forecast = [[ForecastUILable alloc]initWithFrame:CGRectMake(WIDTH / 6 * i, 0, WIDTH / 6, WIDTH / 2 )];
        int chapel = [model.d  intValue];
        if  (i < self.ChinaArray.count) {
            WeatherModel *model1  = self.ChinaArray[i];
            forecast.forecasTitletLable.text = model1.temp_day_tq;
            [forecast.forecastImageView setImage:[self getTemp_day_tq:model1.temp_day_tq]];
        }
        else
        {
            forecast.forecasTitletLable.text  = @"-";
        }
        forecast.dLable.text = array[chapel];
        forecast.dateLable.text =  [self giveDReturndate:model.date];;
        forecast.forecastTHLable.text = [NSString stringWithFormat:@"%@",model.th];
        forecast.forecastTLLable.text = [NSString stringWithFormat:@"%@",model.tl];
        forecast.tag = 100 * (i - 1);
        [self.forecast addSubview:forecast];
    }
}



#pragma mark -
#pragma mark 创建今日天气空气质量详情
- (void)createWeatherDetailView
{
    self.detailView = [[[WeatherDetailView alloc]initWithFrame:CGRectMake(10, HEIGHT + WIDTH / 2 + 100, WIDTH - 20, WIDTH / 2)]autorelease];
    [self.detailView setBackgroundColor:[UIColor grayColor]];
    self.detailView.clipsToBounds = YES;
    self.detailView.layer.cornerRadius = 5;
    [self.detailView setAlpha:0.5];
    [self.bgScroll addSubview:self.detailView];
}



#pragma mark -
#pragma mark 创建风的view
- (void)createWindView
{
    self.wind = [[[WindView alloc]initWithFrame:CGRectMake(10, HEIGHT + WIDTH + 140, WIDTH - 20, WIDTH / 2)]autorelease];
    [self.wind setBackgroundColor:[UIColor grayColor]];
    self.wind.clipsToBounds = YES;
    self.wind.layer.cornerRadius = 5;
    [self.wind setAlpha:0.5];
    [self.bgScroll addSubview:self.wind];
}

#pragma mark -
#pragma 太阳view
- (void)createSunView
{
    WeatherModel *model = self.sun_phaseArray[0];
    SunView *sun = [[SunView alloc]initWithFrame:CGRectMake(10, HEIGHT + WIDTH * 1.5 + 180, WIDTH - 20 , WIDTH / 2)];
    [sun setBackgroundColor:[UIColor grayColor]];
    [sun setAlpha:0.5];
    sun.clipsToBounds = YES;
    sun.layer.cornerRadius = 5;
    sun.ssLable.text = model.ss;
    sun.srLable.text  = model.sr;
    [self.bgScroll addSubview:sun];
    
    DrawLineView *line = [[DrawLineView alloc]initWithFrame:CGRectMake(10, HEIGHT + WIDTH * 1.5 + 180, WIDTH - 20 , WIDTH / 2)];
    [line setBackgroundColor:[UIColor clearColor]];
    [self.bgScroll addSubview:line];
    
    //对日出日落时间进行字符串截取，放到数组里
    NSArray *second = [model.ss componentsSeparatedByString:@":"];
    NSArray *first = [model.sr componentsSeparatedByString:@":"];
    float firsth = [first[0] floatValue];
    float firstm = [first[1] floatValue];
    float secondh = [second[0] floatValue];
    float secondm = [second[1] floatValue];
    
    NSDateComponents *dateComponent = [self getNowTime];
    float Hour = (float) [dateComponent hour];
    float minu = (float) [dateComponent minute];
    
    float p =  (secondh - firsth) * 60 + secondm - firstm;
    float h = (Hour - firsth) * 60 + minu - firstm;
    float nowPoint = h / p * 200;
    NSLog(@"当前时间点距离日出时间点的坐标%f",nowPoint); //距离日出点坐标的距离
    float totalTime = nowPoint / 200.0 * 6;
    
    if (Hour > firsth && Hour < secondh) {
        CALayer *myLayer=[CALayer layer];
        //设置layer的属性
        myLayer.bounds=CGRectMake(0, 0, 200, 100);
        myLayer.backgroundColor=[UIColor grayColor].CGColor;
        myLayer.position=CGPointMake(19, sun.frame.size.height - 121 );
        myLayer.anchorPoint=CGPointMake(0, 0);
        [sun.layer addSublayer:myLayer];
        
        CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
        anima.duration = totalTime;
        anima.removedOnCompletion= NO;
        anima.fillMode=kCAFillModeForwards;
        anima.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 220 - nowPoint, 100)];
        [myLayer addAnimation:anima forKey:nil];
    }
}

//获取当前时间
- (NSDateComponents *)getNowTime
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return dateComponent;
}

//传入temp_day_tq字符串，返回image
- (UIImage *)getTemp_day_tq:(NSString *)temp_day_tq
{
    
    NSString *str = nil;
    NSArray *imaArr = [NSArray arrayWithObjects:@"snow.png",@"rain.png",@"sunshine.png",@"thunder.png",nil];
    NSArray *array = [NSArray arrayWithObjects:@"雪",@"雨",@"晴",@"雷", nil];
    for (int i = 0; i < 4; i ++) {
        str = array[i];
        if([temp_day_tq rangeOfString:str].location != NSNotFound)
        {
            NSString * s = imaArr[i];
            UIImage *ima = [UIImage imageNamed:s];
            return ima;
        }
    }
    UIImage *ima = [UIImage imageNamed:@"cloud.png"];
    return ima;
}

//返回的是背景图片
- (UIImage *)returnBG_ViewByTemp_day_tq:(NSString *)temp_day_tq
{
    NSString *str = nil;
    NSArray *imaArr = [NSArray arrayWithObjects:@"bg_snow.jpg",@"bg_rain.jpg",@"bg_sun.jpg" ,nil];
    NSArray *array = [NSArray arrayWithObjects:@"雪",@"雨",@"晴", nil];
    for (int i = 0; i < 3; i ++) {
        str = array[i];
        if([temp_day_tq rangeOfString:str].location != NSNotFound)
        {
            NSString * s = imaArr[i];
            UIImage *ima = [UIImage imageNamed:s];
            return ima;
        }
    }
    UIImage *ima = [UIImage imageNamed:@"bg_cloud.jpg"];
    return ima;
}

//传入字符型数字，返回周几
- (NSString *)giveDReturndate:(NSString *)date
{
    NSArray *array = [date componentsSeparatedByString:@"-"];
    NSString *month = array[1];
    if ([month hasPrefix:@"0"]) {
        month = [month substringFromIndex:1];
    }
    NSString *day = array[2];
    if ([day hasPrefix:@"0"]) {
        day = [day substringFromIndex:1];
    }
    NSString *s = [NSString stringWithFormat:@"%@/%@",month,day];
    return s;
}

//传入字符串计算风力
-  (NSString *)givekphReturnsk_fl:(NSString *)sk_fl
{
    if ([sk_fl hasPrefix:@"<"]) {
        return sk_fl;
    }
    else{
        NSArray *array = [sk_fl componentsSeparatedByString:@"~"];
        NSString *s1 = array[0];   int k1 = [s1 intValue];     float  t1 = k1 * 1000.0 / 3600;
        NSString *s2 = array[1];   int k2 = [s2 intValue];     float  t2 = k2 * 1000.0 / 3600;
        NSString *skt = [NSString stringWithFormat:@"%.1f~%.1f米/秒",t1,t2];
        return skt;
    }
}
@end
