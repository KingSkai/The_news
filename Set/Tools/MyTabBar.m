//
//  MyTabBar.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/16.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#define COLORBLUE [UIColor colorWithRed:19 / 255.0 green:158 / 255.0 blue:238 / 255.0 alpha:1]
#define COLORDEFAULT [UIColor colorWithRed:134 / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1]

#import "MyTabBar.h"
#import "Header.h"

@interface MyTabBar ()

@property (nonatomic, retain) UIButton *Select;

@property (nonatomic, retain) UIButton *NewImg;
@property (nonatomic, retain) UIButton *NewsButton;

@property (nonatomic, retain) UIButton *ReadImg;
@property (nonatomic, retain) UIButton *ReadButton;

@property (nonatomic, retain) UIButton *VideoImg;
@property (nonatomic, retain) UIButton *VideoButton;

@property (nonatomic, retain) UIButton *SetImg;
@property (nonatomic, retain) UIButton *SetButton;



@end

@implementation MyTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar removeFromSuperview];
    
    self.myTabBar = [[UIView alloc] init];
    self.myTabBar.frame = CGRectMake(0, HEIGHT - 50, WIDTH, 50);
    self.myTabBar.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:255 / 255.0 blue:240 / 255.0 alpha:1];
    self.myTabBar.backgroundColor = [UIColor whiteColor];
    self.myTabBar.layer.borderWidth = 0.5;
    self.myTabBar.layer.borderColor = [UIColor grayColor].CGColor;
    self.myTabBar.alpha = 0.95;
    [self.view addSubview:self.myTabBar];

    self.NewImg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.NewImg.frame = CGRectMake(WIDTH / 12 + 2, 0, 30, 30);
    [self.NewImg setImage:[UIImage imageNamed:@"nav_news_1"] forState:UIControlStateNormal];
    [self.NewImg setImage:[UIImage imageNamed:@"nav_news_1"] forState:UIControlStateHighlighted];
    self.NewImg.tag = 1000;
    [self.NewImg setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [self.NewImg addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTabBar addSubview:self.NewImg];
    [self.NewImg release];

    // 新闻
    self.NewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.NewsButton.frame = CGRectMake(WIDTH / 12, 25, 30, 25);
    [self.NewsButton setTitle:@"新闻" forState:UIControlStateNormal];
    [self.NewsButton setTitleColor:COLORBLUE forState:UIControlStateNormal];
    self.NewsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.NewsButton.tag = 1000;
    self.NewsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.NewsButton addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTabBar addSubview:self.NewsButton];
    
    self.ReadImg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ReadImg.frame = CGRectMake(WIDTH * 3 / 9, 0, 30, 30);
    [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_1"] forState:UIControlStateNormal];
    [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_1"] forState:UIControlStateHighlighted];

    [self.myTabBar addSubview:self.ReadImg];
    self.ReadImg.tag = 2000;
    [self.ReadImg addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ReadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ReadButton.frame = CGRectMake(WIDTH / 9 * 3 - 2, 25, 30, 25);
    
    // 阅读
    [self.ReadButton setTitle:@"阅读" forState:UIControlStateNormal];
    self.ReadButton.tag = 2000;
    self.ReadButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.ReadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.ReadButton addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.ReadButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
    [self.myTabBar addSubview:self.ReadButton];
    
    self.VideoImg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.VideoImg.frame = CGRectMake(WIDTH / 9 * 5, 0, 30, 30);
    self.VideoImg.tag = 3000;
    [self.VideoImg setImage:[UIImage  imageNamed:@"nav_shiping_1"] forState:UIControlStateNormal];
    [self.VideoImg setImage:[UIImage  imageNamed:@"nav_shiping_1"] forState:UIControlStateHighlighted];

    [self.myTabBar addSubview:self.VideoImg];
    [self.VideoImg addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    
    // 视听
    self.VideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.VideoButton.frame = CGRectMake(WIDTH / 9 * 5, 25, 30, 25);
    [self.VideoButton setTitle:@"视听" forState:UIControlStateNormal];
    self.VideoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.VideoButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
    self.VideoButton.tag = 3000;
    self.VideoButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [VideoButton setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [self.VideoButton addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTabBar addSubview:self.VideoButton];
    
    

    
    self.SetImg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SetImg.frame = CGRectMake(WIDTH / 12 * 9.5 + 2, 3 , 27, 27);
    self.SetImg.tag = 4000;
    [self.SetImg setImage:[UIImage  imageNamed:@"nav_shezhi_1"] forState:UIControlStateNormal];
    [self.SetImg setImage:[UIImage  imageNamed:@"nav_shezhi_1"] forState:UIControlStateHighlighted];

    [self.myTabBar addSubview:self.SetImg];
    [self.SetImg addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置
    self.SetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SetButton.frame = CGRectMake(WIDTH / 12 * 9.5, 25, 30, 25);
    [self.SetButton setTitle:@"设置" forState:UIControlStateNormal];
    self.SetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.SetButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
    self.SetButton.tag = 4000;
    self.SetButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [SetButton setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [self.SetButton addTarget:self action:@selector(random:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTabBar addSubview:self.SetButton];
    
    // 第一次 按钮所在位置
    [self random:self.NewsButton];
}

-(void)random:(UIButton *)button
{
    //让当前选中的按钮取消选中
    
    self.Select.selected = NO;
    
    //让新点击的按钮选中
    
    button.selected = YES;
    
    //新点击的按钮就成为了当前选中的按钮
    
    self.Select = button;
    
    
    //控制器连接按钮
    self.selectedIndex = button.tag / 1000 - 1;

    if (button.tag == 1000) {
        NSLog(@"123123");
        [self.NewImg setImage:[UIImage imageNamed:@"nav_news_2"] forState:UIControlStateNormal];
        [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_1"] forState:UIControlStateNormal];
        [self.VideoImg setImage:[UIImage imageNamed:@"nav_shiping_1"] forState:UIControlStateNormal];
        [self.SetImg setImage:[UIImage imageNamed:@"nav_shezhi_1"] forState:UIControlStateNormal];
        
        [self.NewsButton setTitleColor:COLORBLUE forState:UIControlStateNormal];
        [self.ReadButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.VideoButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.SetButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
    }
    if (button.tag == 2000) {
        [self.NewImg setImage:[UIImage imageNamed:@"nav_news_1"] forState:UIControlStateNormal];
        [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_2"] forState:UIControlStateNormal];
        [self.VideoImg setImage:[UIImage imageNamed:@"nav_shiping_1"] forState:UIControlStateNormal];
        [self.SetImg setImage:[UIImage imageNamed:@"nav_shezhi_1"] forState:UIControlStateNormal];
        
        [self.NewsButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.ReadButton setTitleColor:COLORBLUE forState:UIControlStateNormal];
        [self.VideoButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.SetButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        
    }
    if (button.tag == 3000) {
        [self.NewImg setImage:[UIImage imageNamed:@"nav_news_1"] forState:UIControlStateNormal];
        [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_1"] forState:UIControlStateNormal];
        [self.VideoImg setImage:[UIImage imageNamed:@"nav_shiping_2"] forState:UIControlStateNormal];
        [self.SetImg setImage:[UIImage imageNamed:@"nav_shezhi_1"] forState:UIControlStateNormal];
        
        [self.NewsButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.ReadButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.VideoButton setTitleColor:COLORBLUE forState:UIControlStateNormal];
        [self.SetButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
    }
    if (button.tag == 4000) {
        [self.NewImg setImage:[UIImage imageNamed:@"nav_news_1"] forState:UIControlStateNormal];
        [self.ReadImg setImage:[UIImage imageNamed:@"nav_read_1"] forState:UIControlStateNormal];
        [self.VideoImg setImage:[UIImage imageNamed:@"nav_shiping_1"] forState:UIControlStateNormal];
        [self.SetImg setImage:[UIImage imageNamed:@"nav_shezhi_2"] forState:UIControlStateNormal];
        
        [self.NewsButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.ReadButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.VideoButton setTitleColor:COLORDEFAULT forState:UIControlStateNormal];
        [self.SetButton setTitleColor:COLORBLUE forState:UIControlStateNormal];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
