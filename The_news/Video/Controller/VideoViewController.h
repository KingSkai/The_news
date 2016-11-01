//
//  VideoViewController.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface VideoViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,retain)NSString *address;


//时间选择器
@property (nonatomic,strong)UIDatePicker *datePicker;

//当前时间
@property(nonatomic,strong)NSDate *date;

// 创建收听界面的tableView
@property (nonatomic,retain)UITableView *table;

//存放cell数据的数组 (当前)
@property (nonatomic,retain)NSMutableArray *videoList;
//
@property (nonatomic,retain)NSMutableArray *pastList;

//使用 MPMoviePlayerController
@property (strong, nonatomic)MPMoviePlayerController *streamPlayer;

@end
