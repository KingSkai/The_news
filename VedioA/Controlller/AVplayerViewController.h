//
//  AVplayerViewController.h
//  音频播放
//
//  Created by 王&甄 on 15/7/21.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVplayerViewController : UIViewController

+ (AVplayerViewController *)shareInstance;
//
- (void)getAvplayer:(NSString *)urlstring;

@property(nonatomic, retain)AVPlayer *avplayer;
@property(nonatomic, retain)NSString *urlstring;

@property(nonatomic, retain)NSMutableArray *temarr;
@property(nonatomic, assign)NSInteger rownbr;



@property(nonatomic, retain)UIProgressView *progressV;      //播放进度
@property(nonatomic, retain)UISlider *volumeSlider;         //声音控制
@property(nonatomic, retain) NSTimer *timer; //监控音频播放进度



@end
