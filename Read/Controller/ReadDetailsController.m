//
//  ReadDetailsController.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ReadDetailsController.h"
#import <ShareSDK/ShareSDK.h>
#import "UIImageView+WebCache.h"


@interface ReadDetailsController ()
@property (nonatomic, retain) NSString *prama;
@end

@implementation ReadDetailsController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.feed_id = nil;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self creatButton];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  }


- (void)creatButton
{
    

    
    self.prama = [NSString stringWithFormat:@"http://www.36kr.com/p/%@.html", self.model.feed_id];

    if ([self.prama isEqualToString:@"http://www.36kr.com/p/(null).html"]) {
        self.prama = [NSString stringWithFormat:@"http://www.36kr.com/p/%@.html", self.feed_id];
    }
    
    // 创建视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    // 设置webView上的scrollView边界预留
    [webView.scrollView setContentInset:UIEdgeInsetsMake(- 62, 0, - 100, 0)];
    // 边缘弹动效果
    [webView.scrollView setBounces:NO];
    // 加载请求
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.prama]]];
    // 添加父视图
    [self.view addSubview:webView];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title = @"阅读";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil]];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *fenxiangButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiangButton.frame = CGRectMake(0, 0, 25, 25);
    [fenxiangButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [fenxiangButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:fenxiangButton];
    self.navigationItem.rightBarButtonItem = leftButton;
}

- (void)share
{
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQ] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQSpace] == 0) {
      
        
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
    } else {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
        
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:self.model.title
                                           defaultContent:self.model.title
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:@"博闻News"
                                                      url:@"http://weibo.com/u/2495565181?skip_upgrade=1&uut=fin"
                                              description:self.model.title
                                                mediaType:SSPublishContentMediaTypeNews];
        //创建弹出菜单容器
        id<ISSContainer> container = [ShareSDK container];
        
        //弹出分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:nil
                               content:publishContent
                         statusBarTips:YES
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSResponseStateSuccess)
                                    {
                                        NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    }
                                }];
    }

}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];

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
