//
//  AboutUsController.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/16.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Header.h"
#import "AboutUsController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务条款";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    // 内容大小小于scroll时可以滑动
    scroll.contentSize = CGSizeMake(WIDTH, HEIGHT - 1);
    // 当前位置
    scroll.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:scroll];
    [scroll release];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bgImg.image = [UIImage imageNamed:@"aboutBG.jpg"];
    [scroll addSubview:bgImg];
    [bgImg release];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60, 20, 100, 100)];
    [img setClipsToBounds:YES];
    img.layer.cornerRadius  = 8;
    img.image = [UIImage imageNamed:@"Logo.jpg"];
    [bgImg addSubview:img];
    [img release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, WIDTH - 20, 400)];
    label.textColor = [UIColor whiteColor];
    label.text = @"     版本信息:1.0    \n     博文iPhone版适用于iOS 8.0 及以上系统的设备。本软件的下载、安装完全免费，使用过程中产生的数据流量费用，由运营商收取。如在其他手机系统上使用本软件，对于出现的任何问题，开发人员不承担任何责任。本软件是由博文开发小组自主开发，非经博文开发小组授权开发并正式发布的其他任何由本软件衍生的软件均属非法，下载、安装、使用此类软件将可能导致不可预知的风险，由此产生的法律责任与纠纷一概与开发者无关。\n     博文开发小组版权所有\n     Copyright ©2014-2015 \n     BoWen-Inc. All Right Reserved";
    label.numberOfLines = 0;
    [bgImg addSubview:label];
    [label release];
    
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
