
//
//  DBPlayViewController.m
//  The_news
//
//  Created by dlios on 15/7/22.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DBPlayViewController.h"
#import "Header.h"
@interface DBPlayViewController ()



@end

@implementation DBPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
     [self createMyPlayView];
}
- (void)dealloc
{
    [self.playUrl release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


//创建播放界面
-  (void)createMyPlayView
{
    
    NSURL *Url = [NSURL URLWithString:self.playUrl];
    
    self.MPPlayer  = [[MPMoviePlayerController alloc]initWithContentURL:Url];
    [self.MPPlayer.view setFrame:self.view.frame];
    self.MPPlayer.controlStyle = MPMovieControlStyleEmbedded ;
    [self.view addSubview:self.MPPlayer.view];
    [self.MPPlayer play];
                                
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.MPPlayer stop];
    [self.MPPlayer.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
