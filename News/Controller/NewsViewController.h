//
//  NewsViewController.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocButton.h"

@interface NewsViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property(nonatomic, retain)NSMutableArray *nameArr;
@property(nonatomic, assign)NSInteger index;


@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,retain)NSString *address;

@property (nonatomic,retain)LocButton *Now;

@end
