//
//  DBPlayViewController.h
//  The_news
//
//  Created by dlios on 15/7/22.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface DBPlayViewController : UIViewController
@property (strong, nonatomic)MPMoviePlayerController *MPPlayer;
@property (nonatomic,copy)NSString *playUrl;
@end
