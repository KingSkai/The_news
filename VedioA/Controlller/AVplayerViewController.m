//
//  AVplayerViewController.m
//  音频播放
//
//  Created by 王&甄 on 15/7/21.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "AVplayerViewController.h"
#import "ThirdViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface AVplayerViewController ()
@property(nonatomic, retain)AVPlayerItem *item;
@property(nonatomic, retain)UILabel *labler;
@property(nonatomic, retain)UILabel *lableD;
@property(nonatomic, retain)UILabel *lableC;
@property(nonatomic, retain) UIImageView *bigimg;

@property(nonatomic, retain)UIButton *button;
@end

static AVplayerViewController* single = nil;

@implementation AVplayerViewController
static NSInteger counter;
+ (AVplayerViewController *)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init] ;
    }) ;
    return single ;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = self.rownbr;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageview];
    [imageview setImage:[UIImage imageNamed:@"aa.jpg"]];
    [imageview release];
    
    UIImageView *imageviewS = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageview.bounds.size.height - 120, self.view.frame.size.width, 80)];
    imageviewS.backgroundColor = [UIColor whiteColor];
    imageviewS.alpha = 0.5;
    [imageview addSubview:imageviewS];
    
    UIButton *buttong = [UIButton buttonWithType:UIButtonTypeCustom];
    buttong.frame = CGRectMake(10, 30, 20, 20);
    [buttong setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:buttong];
    
    [buttong addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageviewf = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    imageviewf.backgroundColor = [UIColor whiteColor];
    imageviewf.alpha = 0.8;
    [imageview addSubview:imageviewf];
    
    UIButton *voicebfutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voicebfutton setImage:[UIImage imageNamed:@"iconfont-yinliang"] forState:UIControlStateNormal];
    [voicebfutton setImage:[UIImage imageNamed:@"cutupvoice"] forState:UIControlStateSelected];
    
    
    [voicebfutton addTarget:self action:@selector(onOrOff:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voicebfutton];
    voicebfutton.frame = CGRectMake(30, imageviewf.bounds.size.height, 20, 20);
    
    //初始化音量控制
    self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, 60, self.view.frame.size.width - 120, 20)];
    [ self.volumeSlider addTarget:self action:@selector(volumeChange) forControlEvents:UIControlEventValueChanged];
    //设置最小音量
    self.volumeSlider.minimumValue = 0.0f;
    //设置最大音量
    self.volumeSlider.maximumValue = 1.0f;
    //初始化音量为多少
    self.volumeSlider.value = 0.02f;
    
    [self.view addSubview: self.volumeSlider];
    [ self.volumeSlider release];
    
    self.volumeSlider.minimumTrackTintColor = [UIColor colorWithRed:244.0f/255.0f green:147.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
    self.volumeSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"player-progress-point-h"] forState:UIControlStateNormal];
    
    //初始化一个播放进度条
    self.progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(60, imageview.bounds.size.height - 80 - 50, self.view.frame.size.width - 120, 30)];
    [self.view addSubview: self.progressV];
    
    [ self.progressV release];
    self.lableC = [[UILabel alloc]initWithFrame:CGRectMake(15, imageview.bounds.size.height - 80 - 60, 40, 20)];
    self.lableC.backgroundColor = [UIColor clearColor];
    self.lableC.textAlignment = NSTextAlignmentRight;
    [self.lableC setFont:[UIFont systemFontOfSize:10]];
    self.lableC.text = @"00 : 00";
    [self.view addSubview:self.lableC];
    [self.lableC release];
    
    self.lableD = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 15 - 40, imageview.bounds.size.height - 80 - 60, 40, 20)];
    self.lableD.backgroundColor = [UIColor clearColor];
    self.lableD.textAlignment = NSTextAlignmentLeft;
    [self.lableD setFont:[UIFont systemFontOfSize:10]];
    self.lableD.text = @"00 : 00";
    [self.view addSubview:self.lableD];
    [self.lableD release];
    
    [imageviewS release];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.view.frame.size.height - 75 - 30, 60, 50)];
    
    [self.button setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"iconfont-bofang-3"] forState:UIControlStateSelected];
    
    [self.button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.button];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(self.view.frame.size.width / 2 - 20 + 55 + 60, self.view.frame.size.height - 65 - 30, 30, 30)];
    //[button3 setTitle:@"下一首" forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"iconfont-yulexiayishou"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(nextSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 setFrame:CGRectMake(self.view.frame.size.width / 2 - 20 - 55 - 50, self.view.frame.size.height - 65 - 30, 30, 30)];
    //[button4 setTitle:@"上一首" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(headerSong) forControlEvents:UIControlEventTouchUpInside];
    [button4 setBackgroundImage:[UIImage imageNamed:@"iconfont-shangyishou"] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    self.bigimg = [[UIImageView alloc]init];
    self.bigimg.frame = CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 100, 200, 200);
    self.bigimg.backgroundColor = [UIColor clearColor];
    [self.bigimg.layer setCornerRadius:100];
    [self.view addSubview:self.bigimg];
    self.bigimg.image = [UIImage imageNamed:@"1.jpg"];
    self.bigimg.clipsToBounds = YES;
    [self.bigimg release];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //开始
    animation.fromValue = [NSNumber numberWithInt:0];
    //结束
    animation.toValue = [NSNumber numberWithInt:260];
    animation.duration = 260;
    animation.autoreverses = YES;
    animation.repeatCount = NSIntegerMax;
    [_bigimg.layer addAnimation:animation forKey:@"ss"];
    [self.avplayer play];
    
    
    UIImageView *smallimg = [[UIImageView alloc]init];
    smallimg.frame = CGRectMake(self.view.frame.size.width / 2 - 15, self.view.frame.size.height / 2 - 15, 30, 30);
    smallimg.backgroundColor = [UIColor whiteColor];
    [smallimg.layer setCornerRadius:15];
    
    [smallimg.layer setBorderColor:[[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1] CGColor]];
    [smallimg.layer setBorderWidth:2];
    [self.view addSubview:smallimg];;
    [smallimg release];
    //用NSTimer来监控音频播放进度
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
    
}
- (void)goback{
    [self.avplayer pause];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)fastgoahead{
    
}
-(void)bastback{
    
}

- (void)volumeChange
{
    self.avplayer.volume = self.volumeSlider.value;
}

- (void)onOrOff:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        self.avplayer.volume = 0;
        
    }else{
        self.avplayer.volume = self.volumeSlider.value;
    }
}

//播放进度条
- (void)playProgress
{
    
    self.progressV.progress = CMTimeGetSeconds(self.item.currentTime) / CMTimeGetSeconds(self.item.duration);
    
    //获取音频的总时间
    NSTimeInterval totalTimer = CMTimeGetSeconds(self.item.duration);
    //获取音频的当前时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.item.currentTime);
    
    //把秒转换成分钟
    NSTimeInterval currentM = CMTimeGetSeconds(self.item.currentTime) / 60;
    currentTime = (int)CMTimeGetSeconds(self.item.currentTime)%60;
    
    NSTimeInterval totalM = CMTimeGetSeconds(self.item.duration)/60;
    totalTimer = (int)CMTimeGetSeconds(self.item.duration)%60;
    
    //把时间显示在lable上
    NSString *timeC = [NSString stringWithFormat:@"%02.0f:%02.0f",currentM, currentTime];
    
    NSString *timeD = [NSString stringWithFormat:@"%02.0f:%02.0f", totalM,totalTimer];
    self.lableD.text = timeD;
    self.lableC.text = timeC;
    
    
}

//- (void)playDidTouch:(id)sender {
- (void)start:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.avplayer pause];
    }else{
        [self.avplayer play];
        
    }
    
    
}
//self.avplayer

- (void)getAvplayer:(NSString *)urlstring{
    NSString *str = [NSString stringWithFormat:@"http://od.qingting.fm%@", urlstring];
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:str]];
    self.item = [AVPlayerItem playerItemWithAsset:asset];
    if (self.avplayer.currentItem) {
        [self.avplayer replaceCurrentItemWithPlayerItem:self.item];
    }else{
        self.avplayer = [[AVPlayer alloc]initWithPlayerItem:self.item];
    }
    //旋转动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //开始
    animation.fromValue = [NSNumber numberWithInt:0];
    //结束
    animation.toValue = [NSNumber numberWithInt:260];
    animation.duration = 260;
    animation.autoreverses = YES;
    animation.repeatCount = NSIntegerMax;
    [_bigimg.layer addAnimation:animation forKey:@"ss"];
    [self.avplayer play];
    
    
}
- (void)headerSong{
    NSLog(@"A%ld",counter);
    counter--;
    if (counter > 0 && counter < self.temarr.count) {
        NSLog(@"B%ld", counter);
        [self getAvplayer:[self.temarr[counter] objectForKey:@"download"]];
    }else if(counter < 0){
        NSLog(@"first song");
        counter = 0;
    }
}

- (void)nextSong{
    // NSLog(@"%@", self.temarr);
    NSLog(@"%ld", counter);
    counter++;
    NSLog(@"B %ld", counter);
    [self getAvplayer:[self.temarr[counter] objectForKey:@"download"]];
    if (counter > 0 && counter < self.temarr.count) {
        NSLog(@"B%ld", counter);
        [self getAvplayer:[self.temarr[counter] objectForKey:@"download"]];
    }else if(counter > self.temarr.count){
        NSLog(@"last song");
        counter = self.temarr.count;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pause{
    [self.avplayer pause];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
