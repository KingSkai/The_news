//
//  ViewController2.m
//  相册homework
//
//  Created by dllo on 15/4/25.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "LeadViewController.h"
@interface LeadViewController ()<UIScrollViewDelegate>

@end

@implementation LeadViewController
- (void)dealloc
{
    [_array2 release];
    [super dealloc];
    
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.array2 = [NSMutableArray array];
        
    }
    return self;
}

- (void)bScrollView
{
    
    self.b = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _b.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    _b.tag = 10;
    _b.showsHorizontalScrollIndicator = NO;
    _b.delegate = self;
    [self.view addSubview:_b];
    _b.contentOffset = CGPointMake(self.view.frame.size.width * self.numb, 0);
    
    _b.pagingEnabled = YES;
    
    for (int i = 0; i < 3; i++) {
        
        UIScrollView *aSV = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        aSV.delegate = self;
        aSV.minimumZoomScale = 0.5;
        aSV.maximumZoomScale = 2;
        

        UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        bImageView.userInteractionEnabled = YES;
        NSString *str = [NSString stringWithFormat:@"lead_%d_meitu",i + 1];
        [bImageView setImage:[UIImage imageNamed:str]];
        
        if (i == 2) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 , 40)];
            [button setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 5 * 4)];
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            button.titleLabel.font  = [UIFont boldSystemFontOfSize:18];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bImageView addSubview:button];
            [button release];
        }
        
        [aSV addSubview:bImageView];
        [_b addSubview:aSV];
        [aSV release];
        
    }
    [_b release];
}


- (void)buttonAction:(id)sender
{
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotificationName:@"abc" object:self userInfo:nil];

}


- (void)aPage
{
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 600, self.view.frame.size.width, 60)];
    _page.numberOfPages = 3;
    _page.currentPage = _b.contentOffset.x /_b.frame.size.width;
    [_page addTarget:self action:@selector(huan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_page];
    [_page release];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews firstObject];
}
- (void)huan:(id)sender
{
    self.page = (UIPageControl *)sender;
    NSInteger width = self.view.frame.size.width;
    self.b.contentOffset = CGPointMake(self.page.currentPage * width, 0);
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.page.currentPage = page;
    
    
    UIScrollView *scro = (UIScrollView *)[self.view viewWithTag:10];
    if (scro == scrollView) {
        NSArray *array = scrollView.subviews;
        for (UIScrollView *small in array) {
            if ([small isKindOfClass:[UIScrollView class]]) {
                [small setZoomScale:1.0f];
            }
        }
    }
}






- (void)loadView
{
    [super loadView];
    [self bScrollView];
    [self aPage];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
