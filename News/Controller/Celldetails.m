//
//  Celldetails.m
//  The_news
//
//  Created by 王&甄 on 15/7/17.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Celldetails.h"
#import "CelldetailsModel.h"
#import "CellPicsModel.h"
#import "NewsModel.h"
#import "NetWorkTools.h"
#import "AFNetworking.h"
#import "Header.h"
#import <ShareSDK/ShareSDK.h>

@interface Celldetails ()<UIWebViewDelegate>
@property(nonatomic, retain)CelldetailsModel *detailsModel;
@property(nonatomic, retain)CellPicsModel *picModel;
@property(nonatomic, retain)NSArray *news;
@property(nonatomic, retain)UIWebView *web;
@property(nonatomic, retain)NewsModel *newsModel;
@property(nonatomic, retain)NSString *titlestr;
@property(nonatomic, retain) UILabel *headerl;

@end

@implementation Celldetails


- (void)viewDidLoad {
    [super viewDidLoad];
    self.web.delegate  =self;
    self.web = [[UIWebView alloc]init];
    self.web.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self.web.scrollView setBounces:NO];
    [self.view addSubview:self.web];
    [self.web sizeToFit];
    CGRect rectheaderL = CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2, 0,self.view.frame.size.width , 30);
    self.headerl = [[UILabel alloc]init];
    self.headerl.frame = rectheaderL;
    self.headerl.textAlignment = NSTextAlignmentCenter;
    self.headerl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerl];
    [self.headerl setFont:[UIFont boldSystemFontOfSize:20]];
    
    [self.headerl release];
    
    UIView *view = [[UIView alloc]init];
    view.center = CGPointMake([UIScreen mainScreen].bounds.origin.x, 30);
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 40, 100, 40);
    
    //
    UILabel *lable1 = [[UILabel alloc]initWithFrame:view.bounds];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"新闻详情";
    lable1.textColor = [UIColor whiteColor];
    //   [lable1 sizeToFit];
    lable1.textAlignment = NSTextAlignmentCenter;
    [lable1 setFont:[UIFont boldSystemFontOfSize:17]];
    self.navigationItem.titleView = lable1;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(Action)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(30, 0, 30, 60)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fenxiang"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    
    [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(30, 60, 30, 0)];
    
    
    
    //数据加载
    
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.docidd];
    NSString *lurl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // http://c.m.163.com/nc/article/AUN0BNND0001124J/full.html
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil] ];
    [manger GET:lurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
            self.detailsModel = [CelldetailsModel cellDetailsWithdic:responseObject[self.docidd]];
            NSDictionary *dic = responseObject;
            NSDictionary *temdic = [dic objectForKey:self.docidd];
            self.titlestr = [temdic objectForKey:@"title"];
            self.headerl.text = self.titlestr;
            
            [self showWeb];
        }else{
            NSLog(@"error");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
    
}



-(void)creat{
    
    
    
    
}
- (void)Action{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)share
{
    
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQ] == 0 && [ShareSDK hasAuthorizedWithType:ShareTypeQQSpace] == 0) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        [alt release];
    } else {

#pragma share SDK
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
        
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                           defaultContent:@"测试一下"
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:@"ShareSDK"
                                                      url:@"http://www.mob.com"
                                              description:@"这是一条测试信息"
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


- (NSArray *)news{
    if (_news == nil) {
        _news = [NSArray array];
        _news = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _news;
}

- (void)showWeb{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.web loadHTMLString:html baseURL:nil];
    
}
- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    //  [body appendFormat:@"<div class=\"title\">%@</div>",self.detailsModel.title];
    
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailsModel.ptime];
    if (self.detailsModel.body != nil) {
        [body appendString:self.detailsModel.body];
    }
    // 遍历img
    for (CellPicsModel *detailImgModel in self.detailsModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
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
