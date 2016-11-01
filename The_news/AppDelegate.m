//
//  AppDelegate.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 wk. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "ReadViewController.h"
#import "SetViewController.h"
#import "VideoViewController.h"
#import "SetViewController.h"
#import "MyTabBar.h"
#import "Header.h"

#pragma mark - shareSDK USE

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>

#import "LeadViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate, UIApplicationDelegate>

@property (strong, nonatomic) SetViewController *setController;
@property (strong, nonatomic) UINavigationController *mainNavigationController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //self.mainNavigationController.title = @"博闻";
    
    self.window = [[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    
    
    [self.window makeKeyAndVisible];
    
    // 解决办法    2 个key: @”everLaunched”判断用户以前是否登录,@”firstLaunch” 用来开发者在程序的其他部分判断.
    // 在第一次启动的时候 key @”everLaunched” 不会被赋址的, 并且设置为YES. @”firstLaunch” 被设置为 YES.
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    //
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        
        LeadViewController  *vie = [[LeadViewController alloc] init];
        [_window setRootViewController:vie];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setRoot) name:@"abc" object:nil];
    }
    else
    {
        
        [self setRoot];
    }
    
    
    
    return YES;
}

- (void)setRoot
{
    [self.mainNavigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:19 / 255.0 green:158 / 255.0 blue:238 / 255.0 alpha:1]];
    
    
    // 创建视图控制器
    NewsViewController *oneVC = [[[NewsViewController alloc]init]autorelease];
    oneVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"阅读" image:[UIImage imageNamed:@"1.png"] tag:1000]autorelease];
    
    // 创建导航
    
    UINavigationController *navi = [[[UINavigationController alloc] initWithRootViewController:oneVC]autorelease];
    // 第二个标签
    ReadViewController *twoVC = [[[ReadViewController alloc] init]autorelease];
    UINavigationController *navi2 = [[[UINavigationController alloc] initWithRootViewController:twoVC]autorelease];
    twoVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"阅读" image:[UIImage imageNamed:@"2.png"] tag:2000]autorelease];
    
    // 第三个标签
    VideoViewController *threeVC = [[[VideoViewController alloc] init]autorelease];
    UINavigationController *navi3 = [[[UINavigationController alloc]initWithRootViewController:threeVC]autorelease];
    threeVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"视听" image:[[UIImage imageNamed:@"3.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:3000]autorelease];
    // 第四个标签
    SetViewController *fourVC = [[[SetViewController alloc] init]autorelease];
    UINavigationController *navi4 = [[[UINavigationController alloc]initWithRootViewController:fourVC]autorelease];
    fourVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"4.png"] tag:4000]autorelease];
    

    
    MyTabBar *myTabBar = [[[MyTabBar alloc] init] autorelease];
    myTabBar.viewControllers = @[navi, navi2, navi3, navi4];
    myTabBar.delegate = self;
    self.window.rootViewController = myTabBar;
    
    
    
#pragma mark - shareSDK
    [ShareSDK registerApp:@"8f2478802a92"];
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台 （注意：2个方法只用写其中一个就可以）
    // appkey:568898243
    // appSecret:38a4f8204cc784f81f9f0daaf31e02e3
    [ShareSDK connectSinaWeiboWithAppKey:@"2063955693"
                               appSecret:@"4726e39d9532180f74eef7e4518feea2"
                             redirectUri:@"https://itunes.apple.com/cn/genre/ios/id36?mt=8"];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1104706343"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104706343"
                           appSecret:@"bBmpMNsCn44RXL4H"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加Twitter应用  注册网址  https://dev.twitter.com
    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    //连接短信分享
    [ShareSDK connectSMS];
    
    [Parse setApplicationId:@"73oTHZMrMQiVawnoKvQ5QwYXaj0lKILNtly1iXe2"
                  clientKey:@"Trld8P6zptMU6XM2b2u01knoVUEMgLMLUDoP2eeA"];
    
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class]
            tencentOAuthCls:[TencentOAuth class]];
    
    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
    
    
    ///开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    self.reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    [self.reach startNotifier]; //开始监听，会启动一个run loop
    
}

-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return [result autorelease];
}

//通知
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    NSParameterAssert([reach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];
    
    //    //用于检测是否是WIFI
    //    NSLog(@"%d",([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable));
    //    //用于检查是否是3G
    //    NSLog(@"%d",([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable));
    
    if (status == NotReachable) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"抱歉，您网络已断开！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"Notification Says Unreachable");
    }else if(status == ReachableViaWWAN){
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前正在使用数据网络，请注意流量！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"Notification Says mobilenet");
    }
}



#pragma mark - 配置SSO授权
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
