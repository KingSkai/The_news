//
//  SetViewController.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//
#import "SetViewController.h"
#import "AppDelegate.h"
#import "Header.h"
#import "SetCell.h"
#import "AboutUsController.h"
#import "SevenSwitch.h"
#import "MyTabBar.h"
#import "SevenSwitch.h"
#import "LogInNavi.h"
#import "AniView.h"
#import "KVNProgress.h"
#import "DWBubbleMenuButton.h"
#import "LocName.h"
#import "LocImage.h"

#import "DataBaseManager.h"
#import "CollectModel.h"

#import "DBViewController.h"
#import "SDImageCache.h"
#import "UIButton+WebCache.h"

#pragma mark - shareSDK
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>



@interface SetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) AniView *leftView;
@property (nonatomic, retain) SevenSwitch *mySwitch;
@property (nonatomic, retain) AniView *subView;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *buttonTX;
@property (nonatomic, retain) UIButton *buttonZX;
@property (nonatomic, retain) UIButton *buttonXL;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) UIView *AniView;
@property (nonatomic, retain) UIView *AniViewOut;
@property (nonatomic, retain) UIImageView *viewForImage;
@property (nonatomic, retain) UIView *backgroundView;

// button 状态
@property (nonatomic, assign) BOOL buttonState;

// 用户名
@property (nonatomic, retain) UILabel *UserLogInLabel;
// 头像
@property (nonatomic, retain) DWBubbleMenuButton *userHeadButton;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.buttonState = YES;
    
    self.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil]];
    
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
    
    UIImageView *viewBackground = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, WIDTH + 40, 200)];
    viewBackground.image = [UIImage imageNamed:@"BG.jpg"];
    [self.backgroundView addSubview:viewBackground];
    [viewBackground release];
    
    // CABaseAnimation 基础动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithInt:1];
    animation1.toValue = [NSNumber numberWithFloat:1.5];
    animation1.duration = 8.0f;
    animation1.autoreverses = YES;
    animation1.repeatCount = NSIntegerMax;
    [viewBackground.layer addAnimation:animation1 forKey:@"suibian"];
    
    self.viewForImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.viewForImage.layer.cornerRadius = 30;
    self.viewForImage.center = CGPointMake(WIDTH / 2, (viewBackground.frame.size.height / 1.7 + 30 ) / 2 + 15);
    self.viewForImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewForImage.layer.borderWidth = 2;
    self.viewForImage.backgroundColor = [UIColor whiteColor];
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQ] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQSpace] == 0) {
        self.viewForImage.image = [UIImage imageNamed:@"Logo.jpg"];
//        NSLog(@"------------------------------------读取本地 %d", [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]);

    } else {
        [self.viewForImage sd_setImageWithURL:[NSURL URLWithString:[LocImage readLoc]]];

//        self.viewForImage.image = [UIImage imageNamed:@"Logo.jpg"];
//        NSLog(@"------------------------------------没有读取本地%d", [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]);

    }
    [self.viewForImage setClipsToBounds:YES];
    [self.backgroundView addSubview:self.viewForImage];
    [self.viewForImage release];
    
    self.UserLogInLabel = [[UILabel alloc] init];
    self.UserLogInLabel.frame = CGRectMake(WIDTH / 2 - 50, self.viewForImage.center.y + 25 + 10, 100, 20);
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQ] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQSpace] == 0) {
        self.UserLogInLabel.text = @"用户未登录";

    } else {
        self.UserLogInLabel.text = [LocName readLoc];


    }
    self.UserLogInLabel.textAlignment = NSTextAlignmentCenter;
    self.UserLogInLabel.textColor = [UIColor whiteColor];
    self.UserLogInLabel.textAlignment = NSTextAlignmentCenter;
    self.UserLogInLabel.font = [UIFont systemFontOfSize:14];
    [self.backgroundView addSubview:self.UserLogInLabel];
    [self.UserLogInLabel release];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, viewBackground.frame.origin.y + viewBackground.frame.size.height, WIDTH, HEIGHT - viewBackground.frame.origin.y - viewBackground.frame.size.height - 110) style:UITableViewStylePlain];
    self.tableView.tag = 1000;
    self.tableView.scrollEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.backgroundView addSubview:self.tableView];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 180)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.15;
    self.tableView.tableHeaderView = view;
    [view release];
    
    // 上左下右
    self.tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
    self.AniViewOut = [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    self.AniViewOut.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.AniViewOut];
    
    
//    ShareSDK hasAuthorizedWithType:sharet
    UILabel *homeLabel = [self createHomeButtonView];
    DWBubbleMenuButton *downMenuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(60, 60, 150, 150) expansionDirection:DirectionRight];
    downMenuButton.homeButtonView = homeLabel;
    [downMenuButton addButtons:[self createDemoButtonArray]];
    [downMenuButton bringSubviewToFront:self.tableView];
    [self.view addSubview:downMenuButton];
}

#pragma mark - begin
- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0.f, 110.f, 80.f)];
    label.textAlignment = NSTextAlignmentCenter;
    label.clipsToBounds = YES;
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"qq1"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.f, 0.f, 50, 50);
    button.clipsToBounds = YES;
    button.tag = 1;
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [buttonsMutable addObject:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"xl"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(-0.f, 0.f, 50, 50);
    button1.clipsToBounds = YES;
    button1.tag = 2;
    [button1 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [buttonsMutable addObject:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(0.f, 0.f, 50, 50);
    button2.clipsToBounds = YES;
    button2.tag = 3;
    [button2 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [buttonsMutable addObject:button2];
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    if (sender.tag == 1) {
        [self tencent];
    } else if (sender.tag == 2) {
        [self sina];
    } else if (sender.tag == 3) {
        [self leave:sender];
    }
}

- (UIButton *)createButtonWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark - end
- (void)LogIn
{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.AniViewOut.frame = CGRectMake(WIDTH - 120, 0, WIDTH, HEIGHT - 60);
        self.backgroundView.frame = CGRectMake(0 - 120, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation2.fromValue = [NSNumber numberWithInt:0];
        animation2.toValue = [NSNumber numberWithInt:1];
        animation2.duration = 1;
        [self.buttonTX.layer addAnimation:animation2 forKey:@"suibian2"];
        self.buttonTX = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonTX setImage:[UIImage imageNamed:@"qq1"] forState:UIControlStateNormal];
        self.buttonTX.frame = CGRectMake(35, 30, 55, 55);
        
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation3.fromValue = [NSNumber numberWithInt:0];
        animation3.toValue = [NSNumber numberWithInt:1];
        animation3.duration = 1.3f;
        [self.buttonXL.layer addAnimation:animation3 forKey:@"suibian3"];
        self.buttonXL = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonXL setImage:[UIImage imageNamed:@"xinlang1"] forState:UIControlStateNormal];
        self.buttonXL.frame = CGRectMake(35, 110, 60, 60);
        
        CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation4.fromValue = [NSNumber numberWithInt:0];
        animation4.toValue = [NSNumber numberWithInt:1];
        animation4.duration = 1.6f;
        [self.buttonZX.layer addAnimation:animation4 forKey:@"suibian4"];
        self.buttonZX = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonZX setImage:[UIImage imageNamed:@"zhuxiao"] forState:UIControlStateNormal];
        self.buttonZX.frame = CGRectMake(35, 190, 53, 53);
        self.buttonState = NO;
        [self.AniViewOut addSubview:self.buttonTX];
        [self.AniViewOut addSubview:self.buttonXL];
        [self.AniViewOut addSubview:self.buttonZX];
    }];
    
    [self.buttonTX addTarget:self action:@selector(tencent) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonXL addTarget:self action:@selector(sina) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonZX addTarget:self action:@selector(leave:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)reloadStateWithType:(ShareType)type{
    //现实授权信息，包括授权ID、授权有效期等。
    //此处可以在用户进入应用的时候直接调用，如授权信息不为空且不过期可帮用户自动实现登录。
    id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                        message:[NSString stringWithFormat:
                                                                 @"uid = %@\ntoken = %@\nsecret = %@\n expired = %@\nextInfo = %@",
                                                                 [credential uid],
                                                                 [credential token],
                                                                 [credential secret],
                                                                 [credential expired],
                                                                 [credential extInfo]]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                              otherButtonTitles:nil];
    [alertView show];
}

// 注销
- (void)leave:(id)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeQQ];
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    self.viewForImage.image = [UIImage imageNamed:@"Logo.jpg"] ;
    self.UserLogInLabel.text = @"用户未登录";
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注销成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
    [alt release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *Identifier = @"Identifier";
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[SetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //cell的右边有一个小箭头，距离右边有十几像素；
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.label.font = [UIFont systemFontOfSize:20.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.label.font = [UIFont systemFontOfSize:17];
        // 点击颜色
        if (indexPath.row == 0) {
            cell.label.text = @"浏览历史";
            cell.image.image = [UIImage imageNamed:@"LLTakeoutFlowFirstEnabled"];
            cell.image.frame = CGRectMake(5, 8, 30, 30);
        } else if (indexPath.row == 1) {
            cell.label.text = @"我的收藏";
            cell.image.image = [UIImage imageNamed:@"feed_select_fav_icon"];
            cell.image.frame = CGRectMake(8, 10, 25, 25);
        }
        return cell;
    } else {
        static NSString *Identifier = @"Identifier";
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[SetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.label.font = [UIFont systemFontOfSize:20.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.label.font = [UIFont systemFontOfSize:17];
        // 点击颜色
        if (indexPath.row == 0) {
            cell.label.text = @"夜间模式";
            cell.image.image = [UIImage imageNamed:@"feed_select_my_footprint"];
            cell.image.frame = CGRectMake(8, 10, 25, 25);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            SevenSwitch *mySwitch2 = [[SevenSwitch alloc] initWithFrame:CGRectMake(WIDTH - 100, 10, 70, 25)];
            [mySwitch2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            mySwitch2.offImage = [UIImage imageNamed:@"cross.png"];
            mySwitch2.onImage = [UIImage imageNamed:@"check.png"];
            mySwitch2.onColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
            mySwitch2.isRounded = NO;
            [cell.contentView addSubview:mySwitch2];
            [mySwitch2 setOn:YES animated:NO];
        } else if (indexPath.row == 1) {
            cell.label.text = @"清除缓存";
            cell.image.image = [UIImage imageNamed:@"14112022"];
            cell.image.frame = CGRectMake(8, 10, 25, 25);
            self.l = [[UILabel alloc]initWithFrame:CGRectMake(150, 10, 60, 25)];
        } else if (indexPath.row == 2) {
            cell.label.text = @"给个评分";
            cell.image.image = [UIImage imageNamed:@"rate_hao_ping_button"];
            cell.image.frame = CGRectMake(8, 10, 28, 28);
        } else {
            cell.label.text = @"版本信息";
            cell.image.image = [UIImage imageNamed:@"ac04a35953fea30f43ff8c0623f6b5fc.jpg"];
            cell.image.frame = CGRectMake(10, 8, 25, 25);
        }
        return cell;
    }
    
}

//清除文件
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.3f];
    DBViewController *d = [[DBViewController alloc]init];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"浏览历史");
            d.str = @"浏览历史";
            [self.navigationController pushViewController:d animated:YES];
        }
        //        if (indexPath.row == 1) {
        else if (indexPath.row == 1){
            NSLog(@"我的收藏");
            
            d.str =@"我的收藏";
            [self.navigationController pushViewController:d animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [array lastObject];
            path = [NSString stringWithFormat:@"%@/Caches",path];
            NSLog(@"%@",path);
            [self clearCache:path];
            [KVNProgress showSuccessWithStatus:@"清理完成"];
            NSLog(@"Library下Caches文件夹内容已清除");
        }
        if (indexPath.row == 2) {
            NSLog(@"给个评分");
            NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/xing-kongfm/id1002256892?mt=8"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        if (indexPath.row == 3) {
            AboutUsController *about = [[AboutUsController alloc] init];
            
            [self.navigationController pushViewController:about animated:YES];
        }
    }
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

// 给头部区域设置自定义视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // 自定义视图的高度不由当前的试图对象决定
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    v.alpha = 0.15;
    return v;
}

// 控制头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.045 * HEIGHT;
    } else {
        return 0;
    }
}

- (void)tencent
{
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   //打印输出用户uid：
                                   NSLog(@"uid = %@",[userInfo uid]);
                                   //打印输出用户昵称：
                                   NSLog(@"name = %@",[userInfo nickname]);
                                   //打印输出用户头像地址：
                                   NSLog(@"icon = %@",[userInfo profileImage]);
                                   self.UserLogInLabel.text = [userInfo nickname];
                                   [self.viewForImage sd_setImageWithURL:[NSURL URLWithString:[userInfo profileImage]]];
                                   [LocName writeLoc:[userInfo nickname]];
                                   [LocImage writeLoc:[userInfo profileImage]];
                                   
                               }
                               else{
                                   
                                   //                                   NSLog(@"授权失败!error code == %ld, error code == %@", [error errorCode], [error errorDescription]);
                               }
                           }];
}


- (void)sina
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
                                   self.UserLogInLabel.text = [userInfo nickname];
                                   [self.viewForImage sd_setImageWithURL:[NSURL URLWithString:[userInfo profileImage]]];
                                   NSLog(@"uid = %@",[userInfo uid]);
                                   NSLog(@"name = %@",[userInfo nickname]);
                                   NSLog(@"icon = %@",[userInfo profileImage]);
                                   [LocName writeLoc:[userInfo nickname]];
                                   [LocImage writeLoc:[userInfo profileImage]];
                                   //将信息保存到parse上
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query whereKey:@"uid" equalTo:[userInfo uid]];
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       if ([objects count] == 0)
                                       {
                                           PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                                           [newUser setObject:[userInfo uid] forKey:@"uid"];
                                           [newUser setObject:[userInfo nickname] forKey:@"name"];
                                           [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                                           [newUser saveInBackground];
                                       }
                                       else
                                       {
                                       }
                                   }];
                               }
                           }];
}

- (void)switchAction:(id)sender
{
    
    UISwitch *switchButton = (UISwitch *)sender;
    BOOL isButton = [switchButton isOn];
    if (isButton) {
        self.view.window.alpha = 1;
    } else {
        self.view.window.alpha = 0.618;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
