//
//  LogInNavi.m
//  The_news
//
//  Created by 王凯 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "LogInNavi.h"
#import "AniView.h"
#import <ShareSDK/ShareSDK.h>

@interface LogInNavi ()
@property (nonatomic, retain) UIView *aniView;
@end

@implementation LogInNavi

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.aniView = [[AniView alloc] initWithFrame:self.view.bounds];
    self.aniView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.aniView];
    [_aniView release];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithTitle:@"注销"
                                               style:UIBarButtonItemStyleDone
                                               target:self
                                               action:@selector(logoutButtonClickHandler:)]
                                              autorelease];

}

- (void)logoutButtonClickHandler:(id)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    [self.navigationController popViewControllerAnimated:NO];
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
