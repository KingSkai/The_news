//
//  ForecastUILable.h
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastUILable : UILabel
@property (nonatomic,retain)UILabel *dLable;                  //周几
@property (nonatomic,retain)UILabel *dateLable;               //日期
@property (nonatomic,retain)UIImageView *forecastImageView;
@property (nonatomic,retain)UILabel *forecasTitletLable;
@property (nonatomic,retain)UILabel *forecastTHLable;
@property (nonatomic,retain)UILabel *forecastTLLable;
@end
