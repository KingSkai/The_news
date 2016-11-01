//
//  NewsViewController.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.

//

#import "NewsViewController.h"
#import "myCell.h"
#import "myCell2.h"
#import "FlowCell.h"
#import "TenHeaderLable.h"
#import "TenTableViewController.h"
#import "BigImageCell.h"
#import "MakeContect.h"
#import "MJRefresh.h"
#import "Header.h"


@interface NewsViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    CLLocationCoordinate2D myclocation;
    CLGeocoder *gecoder;
}

@property(nonatomic, retain) TenHeaderLable *temlable;
// collection 内容数组
@property (nonatomic, retain) NSMutableArray *arr;
// 添加collection 内容数组
@property (nonatomic, retain) NSMutableArray *arr2;
@property (nonatomic, retain) UIButton *button;

// 瀑布流collection
@property (nonatomic, retain) UICollectionView *scoll4;
@property (nonatomic, retain) UILabel *myLabel;
@property (nonatomic, retain) UILabel *moreLabel;
//创建scrollview
@property(nonatomic, retain)UIScrollView *headerScrollview;
@property(nonatomic, retain)UIScrollView *mainScrollview;
@property(nonatomic, retain)NSArray *arrayLists;
@property(nonatomic, retain)TenHeaderLable *ll;
@property(nonatomic, retain)UIViewController *vcc;
@property(nonatomic, assign)CGFloat lw;
@property(nonatomic, assign)CGFloat lh;
@property(nonatomic, assign)CGFloat ly;
@property(nonatomic, assign)CGFloat lx;
@property(nonatomic, retain)NSMutableArray *restarr;
@property(nonatomic, retain)UIButton *buttonUpdate;

// 动画层view
@property (nonatomic, retain) UIView *view1;
@property (nonatomic, assign) NSMutableArray *itemHightArr;
@property (nonatomic, retain) UICollectionView *scoll;
@property (nonatomic, retain) UICollectionView *scoll2;
@property (nonatomic, retain) UICollectionView *scoll3;




@end

@implementation NewsViewController
//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

//保存url
- (NSArray *)arrayLists{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLLL" ofType:@"plist"]];
        
    }
    return _arrayLists;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//内容定制
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]init];
    view.center = CGPointMake([UIScreen mainScreen].bounds.origin.x, 30);
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(40, 40, 100, 40);
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:view.bounds];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"新闻";
    lable1.textColor = [UIColor whiteColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    [lable1 setFont:[UIFont boldSystemFontOfSize:20]];
    [view addSubview:lable1];
    self.navigationItem.titleView =view;
    
    self.navigationController.navigationBar.translucent = NO;
    // 标题滚动视图
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 30);
    self.headerScrollview = [[UIScrollView alloc]initWithFrame:rect];
    self.headerScrollview.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerScrollview.showsHorizontalScrollIndicator = NO;
    self.headerScrollview.showsVerticalScrollIndicator = NO;
    // [self creatCursor];
    // 主页面滚动视图
    CGRect rectM = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 30);
    self.mainScrollview = [[UIScrollView alloc]initWithFrame:rectM];
    self.mainScrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollview];
    self.mainScrollview.delegate = self;
    self.mainScrollview.pagingEnabled = YES;
    self.arr = [[NSMutableArray alloc]init];
    self.arr2 = [[NSMutableArray alloc]init];
    //两个添加方法
    [self addController];
    NSArray *temparr = [[self childViewControllers] mutableCopy];

    for (int i = 0; i < 17; i++) {
        if (i >= 0 && i < 7) {
            [self.arr addObject:temparr[i]];
        }else{
            [self.arr2 addObject:temparr[i]];
        }
    }
    

    CGFloat contextX = (self.arr.count - 1) * [UIScreen mainScreen].bounds.size.width;
    self.mainScrollview.contentSize = CGSizeMake(contextX, 0);
    [self addheader];
   
    //添加默认控制器
    UIViewController *vc= [self.childViewControllers firstObject];
    vc.view.frame = self.mainScrollview.bounds;
    [self.mainScrollview addSubview:vc.view];
    TenHeaderLable *lable = [self.headerScrollview.subviews firstObject];
    lable.scale = 1;
    // 创建collection
    [self creatCollection];
    // 创建 collection4 瀑布流
    //    [self creatCollection4];
    // 创建抽屉View
    [self creatView];
    // 创建 collection2
    [self creatCollection2];
    // 创建 collection3
    [self creatCollection3];
}

//warning 创建collection - 上方滚动条
- (void)creatCollection
{
    // 滑动视图 自适应边界预留值
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    // 创建collectionView布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // item大小 每一个小方块的大小
    layout.itemSize = CGSizeMake(80, 30);
    // 垂直滑动式 纵向间距可以随意设置 横向间距需要先保证item的显示
    // 水平滑动是 横向间距自定义 竖向间距优先保证item的显示
    // item横向距离
    layout.minimumInteritemSpacing = 10;
    // item上下边距(纵向)
    layout.minimumLineSpacing = 5;
    // 滑动方向 (默认垂直)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // item边界值 (上, 左, 下, 右)
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    
    // collectionView创建时 必须有layout布局信息
    self.scoll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 40) collectionViewLayout:layout];
    
    self.scoll.backgroundColor = [UIColor cyanColor];
    self.scoll.tag = 1001;
    self.scoll.delegate = self;
    self.scoll.dataSource = self;
    //  [self.view addSubview:self.scoll];
    [self.scoll release];
    [layout release];
    
    // 滑动视图的边界 (上, 左, 下, 右)
    self.scoll.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    // 注册重用池
    [self.scoll registerClass:[myCell class] forCellWithReuseIdentifier:@"123"];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(self.scoll.frame.size.width, self.scoll.frame.origin.y, self.view.frame.size.width - self.scoll.frame.size.width, self.scoll.frame.size.height - 5);
    self.button.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"dingzhi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(drop_down:)];
    [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(25, 50, 25, 0)];
    [self.button addTarget:self action:@selector(drop_down:) forControlEvents:UIControlEventTouchUpInside];
 }
- (void)updateScrollview{
    [self.headerScrollview release];
    [self.headerScrollview removeFromSuperview];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 30);
    self.headerScrollview = [[UIScrollView alloc]initWithFrame:rect];
    self.headerScrollview.backgroundColor = [UIColor whiteColor];
    
    self.nameArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.arr.count; i++) {
        self.lw = 50;
        self.lh = 18;
        self.ly = 7;
        self.lx = i * self.lw + 20;
        self.ll = [[TenHeaderLable alloc]init];
        
        self.vcc = self.arr[i];
        
        self.ll.text = self.vcc.title;
        self.ll.tag = i;
        
        [self.nameArr addObject:self.vcc.title];
        
        self.ll.frame = CGRectMake(self.lx, self.ly, self.lw, self.lh);
        
        [self.view addSubview:self.headerScrollview];
        [self.headerScrollview addSubview:self.ll];
        
        self.ll.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(llclick:)];
        [self.ll addGestureRecognizer:recognizer];
        
    }
    self.headerScrollview.contentSize = CGSizeMake(50 * self.arr.count + 50, 0);
    
    
    [self.view addSubview:self.headerScrollview];
    
}
//warning 动画view1
- (void)creatView
{
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, - self.view.frame.size.height - 200, self.view.frame.size.width, self.view.frame.size.height - 80)];

    self.view1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    [self.view1 release];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view1.frame.size.width / 2 - 40, 5, 80, 20)];
    self.myLabel.text = @"我的频道";
    [self.view1 addSubview:self.myLabel];
    [self.myLabel release];
    
    self.moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view1.frame.size.width / 2 - 40, self.scoll2.frame.size.height + 165, 80, 20)];
    self.moreLabel.text = @"更多频道";
    [self.view1 addSubview:self.moreLabel];
    [self.moreLabel release];
    
    UILabel *confirm = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.scoll3.frame.size.height + 320, 60, 20)];
    confirm.textAlignment = NSTextAlignmentCenter;
    confirm.text = @"确认";
    [confirm.layer setBorderWidth:1];
    [confirm.layer setCornerRadius:2];
    [confirm setTextColor:[UIColor blackColor]];
    [confirm setFont:[UIFont systemFontOfSize:14]];
    confirm.backgroundColor = [UIColor whiteColor];
    [self.view1 addSubview:confirm];
    [confirm release];
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateS)];
    [confirm addGestureRecognizer:recognizer];
    confirm.userInteractionEnabled = YES;
    
    
    
}
- (void)updateS{
    [self updateScrollview];
    
    CGPoint offset = CGPointMake(0, 0);
    [self.mainScrollview setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * self.arr.count, self.view.frame.size.height)];
    [self.mainScrollview setContentOffset:offset animated:YES];
    [UIView animateWithDuration:0.8 animations:^{
        // 延迟几秒执行
        [UIView setAnimationDelay:0.2];
        // 改变位置动画
        self.view1.frame = CGRectMake(0, - self.view.frame.size.height - 200, self.view.frame.size.width, self.view.frame.size.height - 80);
    } completion:^(BOOL finished) {
        
    }];
    
}

//warning 创建collection2
- (void)creatCollection2
{
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(80, 30);
    layout1.minimumInteritemSpacing = 10;
    layout1.minimumLineSpacing = 20;
    layout1.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.scoll2 = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 25,[UIScreen mainScreen].bounds.size.width - 20, 120) collectionViewLayout:layout1];
    self.scoll2.delegate = self;
    self.scoll2.dataSource = self;
    [self.scoll2 setBackgroundColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:0.8]];
    self.scoll2.tag = 1002;
    [self.view1 addSubview:self.scoll2];
    [self.scoll2 release];
    [layout1 release];
    // 滑动视图的边界 (上, 左, 下, 右)
    self.scoll2.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    // 注册重用池
    [self.scoll2 registerClass:[myCell2 class] forCellWithReuseIdentifier:@"321"];
}

//warning 创建collection3
- (void)creatCollection3
{
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.itemSize = CGSizeMake(80, 30);
    layout2.minimumInteritemSpacing = 10;
    layout2.minimumLineSpacing = 20;
    layout2.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.scoll3 = [[UICollectionView alloc] initWithFrame:CGRectMake(10, self.scoll2.frame.origin.y + self.scoll2.frame.size.height + 20 + 20, [UIScreen mainScreen].bounds.size.width - 20, 120) collectionViewLayout:layout2];
    self.scoll3.delegate = self;
    self.scoll3.dataSource = self;
    self.scoll3.tag = 1003;
    [self.scoll3 setBackgroundColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:0.8]];
    [self.view1 addSubview:self.scoll3];
    [self.scoll3 release];
    self.scoll3.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    [self.scoll3 registerClass:[myCell class] forCellWithReuseIdentifier:@"213"];
}

//warning 创建瀑布流collection4
- (void)creatCollection4
{
    UICollectionViewFlowLayout *layout4 = [[UICollectionViewFlowLayout alloc] init];
    layout4.itemSize = CGSizeMake(150, 180);
    layout4.minimumInteritemSpacing = 5;
    layout4.minimumLineSpacing = 5;
    layout4.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.scoll4 = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width - 20, 500) collectionViewLayout:layout4];
    self.scoll4.delegate = self;
    self.scoll4.dataSource = self;
    self.scoll4.tag = 1004;
    self.scoll4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scoll4];
    [self.scoll4 release];
    self.scoll4.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    [self.scoll4 registerClass:[myCell class] forCellWithReuseIdentifier:@"444"];
}



//warning 判断每个collection 的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1001) {
        return self.arr.count;
    } else if (collectionView.tag == 1002) {
        return self.arr.count;
    } else if (collectionView.tag == 1003) {
        return self.arr2.count;
    } else {
        return self.itemHightArr.count;
    }
}


//warning collection赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1001) {
        myCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        Model *m = [[Model alloc] init];
        m.name = [self.arr[indexPath.row] title] ;
        cell.model = m;
        return cell;
    } else if (collectionView.tag == 1002) {
        myCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"321" forIndexPath:indexPath];
        if (indexPath.item == 0) {
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            
        }
        
        cell.label.text = [self.arr[indexPath.row] title];
        return cell;
    } else if (collectionView.tag == 1003) {
        myCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"213" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.label.text = [self.arr2[indexPath.row] title];
        return cell;
    }
      return nil;
}

//warning section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 1001) {
        
    } else if (collectionView.tag == 1002) {

        if (indexPath.item != 0 ) {
            [self.arr2 addObject:self.arr[indexPath.item]];
            [self.arr removeObjectAtIndex:indexPath.item];
        }
        
        [self.scoll3 reloadData];
        [self.scoll2 reloadData];
        [self.scoll reloadData];
    } else {
        [self.arr addObject:self.arr2[indexPath.item]];
        [self.arr2 removeObjectAtIndex:indexPath.item];
        [self.scoll2 reloadData];
        [self.scoll3 reloadData];
        [self.scoll reloadData];
    }
}

//warning 动画点击事件
- (void)drop_down:(UIView *)view
{
    
    if (self.view1.frame.origin.y < 0) {
        // 动画
        [UIView animateWithDuration:0.8 animations:^{
            // 延迟几秒执行
            [UIView setAnimationDelay:0.2];
            // 改变位置动画
            self.view1.frame = CGRectMake(0, self.button.frame.origin.y + self.button.frame.size.height, self.view.frame.size.width, 340);
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        //        self.view1.hidden = YES;
        // 动画
        [UIView animateWithDuration:0.8 animations:^{
            // 延迟几秒执行
            [UIView setAnimationDelay:0.2];
            // 改变位置动画
            self.view1.frame = CGRectMake(0, - self.view.frame.size.height - 200, self.view.frame.size.width, self.view.frame.size.height - 80);
        } completion:^(BOOL finished) {
        }];
    }
 
}

// 每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1001) {
        return CGSizeMake(50, 20);
    }
    else if (collectionView.tag == 1002) {
        return CGSizeMake(50, 20);
    }
    else {
        return CGSizeMake(50, 20);
    }
}


// 定位
- (void)loadView
{
    [super loadView];
    [self location];
    
    //自定义定位按钮
    self.Now = [[LocButton alloc] initWithFrame:CGRectMake(60, 0, 50, 20)];
    [self.Now addTarget:self action:@selector(NowClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self.Now.loc setText:@"大连"];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.Now]];
    
}

- (void)NowClick:(id)sender
{
    WeatherViewController *weather = [[WeatherViewController alloc]init];
    [self presentViewController:weather animated:YES completion:nil];
}



#pragma mark -
#pragma mark 定位
- (void)location
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = kCLDistanceFilterNone;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.1;
    theSpan.longitudeDelta = 0.1;
    MKCoordinateRegion theRegion;
    theRegion.center = [[_locationManager location]coordinate];
    theRegion.span = theSpan;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度 = %f  纬度 = %f  高度 = %f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    myclocation.latitude = currLocation.coordinate.latitude;
    myclocation.longitude = currLocation.coordinate.longitude;
    [self showWithlocation:myclocation];
    
}

////根据经纬度解析出地理位置
- (void )showWithlocation:(CLLocationCoordinate2D)location {
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    gecoder = [[CLGeocoder alloc]init];
    
    
    static NSString *name = nil;
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        
        for (CLPlacemark *placemark in place) {
            
            name = [placemark.addressDictionary objectForKey:@"Name"];
            NSString *City = [placemark.addressDictionary objectForKey:@"City"];
            
            NSArray *array = [City componentsSeparatedByString:@"市"];
            NSString *locCity = array[0];
            NSLog(@"%@",locCity);
            [self.Now.loc setText:locCity];
            [LOC writeLoc:locCity];
        }
        
    };
    [gecoder reverseGeocodeLocation:loc completionHandler:handler];
    
}

// 添加标题
- (void)addheader{
    
    self.nameArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.arr.count; i++) {
        self.lw = 50;
        self.lh = 18;
        self.ly = 7;
        self.lx = i * self.lw + 20;
        self.ll = [[TenHeaderLable alloc]init];
        
        self.vcc = self.arr[i];
        
        self.ll.text = self.vcc.title;
        self.ll.tag = i;
        
        [self.nameArr addObject:self.vcc.title];
        
        self.ll.frame = CGRectMake(self.lx, self.ly, self.lw, self.lh);
        
        [self.view addSubview:self.headerScrollview];
        [self.headerScrollview addSubview:self.ll];
        
        self.ll.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(llclick:)];
        [self.ll addGestureRecognizer:recognizer];
        
        
    }
    self.headerScrollview.contentSize = CGSizeMake(50 * self.arr.count + 50, 0);
}

//给标题栏label添加点击事件
- (void)llclick:(UITapGestureRecognizer *)recognizer{
    TenHeaderLable *titlelable = (TenHeaderLable *)recognizer.view;
    CGFloat offsetX = titlelable.tag * self.mainScrollview.frame.size.width;
    CGFloat offsetY = self.mainScrollview.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.mainScrollview setContentOffset:offset animated:YES];
    
    
}
- (void)addController{
    TenTableViewController *vc1 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc1.title = @"要闻";
    vc1.urlString = [self.arrayLists[0] objectForKey:@"urlString"];
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addChildViewController:vc1];
    [vc1 release];
    
    TenTableViewController *vc2 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc2.title = @"NBA";
    vc2.urlString = [self.arrayLists[1] objectForKey:@"urlString"];
    [self addChildViewController:vc2];
    [vc2 release];
    
    
    TenTableViewController *vc3 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc3.title = @"手机";
    vc3.urlString = [self.arrayLists[2] objectForKey:@"urlString"];
    [self addChildViewController:vc3];
    [vc3 release];
    
    TenTableViewController *vc4 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc4.title = @"移动";
    vc4.urlString = [self.arrayLists[3] objectForKey:@"urlString"];
    [self addChildViewController:vc4];
    [vc4 release];
    
    TenTableViewController *vc5 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc5.title = @"娱乐";
    vc5.urlString = [self.arrayLists[4] objectForKey:@"urlString"];
    [self addChildViewController:vc5];
    [vc5 release];
    
    TenTableViewController *vc6 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc6.title = @"时尚";
    vc6.urlString = [self.arrayLists[5] objectForKey:@"urlString"];
    [self addChildViewController:vc6];
    
    
    TenTableViewController *vc7 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc7.title = @"电影";
    vc7.urlString = [self.arrayLists[6] objectForKey:@"urlString"];
    [self addChildViewController:vc7];
    
    TenTableViewController *vc8 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc8.title = @"科技";
    vc8.urlString = [self.arrayLists[8] objectForKey:@"urlString"];
    [self addChildViewController:vc8];
    [vc8 release];
    
    TenTableViewController *vc9 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc9.title = @"军事";
    vc9.urlString = [self.arrayLists[7] objectForKey:@"urlString"];
    [self addChildViewController:vc9];
    [vc9 release];
    
    TenTableViewController *vc10 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc10.title = @"财经";
    vc10.urlString = [self.arrayLists[9] objectForKey:@"urlString"];
    [self addChildViewController:vc10];
    [vc10 release];
    
    TenTableViewController *vc11 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc11.title = @"家装";
    vc11.urlString = [self.arrayLists[10] objectForKey:@"urlString"];
    [self addChildViewController:vc11];
    [vc11 release];
    
    TenTableViewController *vc12 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc12.title = @"教育";
    vc12.urlString = [self.arrayLists[11] objectForKey:@"urlString"];
    [self addChildViewController:vc12];
    [vc12 release];
    
    TenTableViewController *vc13 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc13.title = @"健康";
    vc13.urlString = [self.arrayLists[12] objectForKey:@"urlString"];
    [self addChildViewController:vc13];
    [vc13 release];
    
    TenTableViewController *vc14 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc14.title = @"旅游";
    vc14.urlString = [self.arrayLists[13] objectForKey:@"urlString"];
    [self addChildViewController:vc14];
    [vc14 release];
    
    TenTableViewController *vc15 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc15.title = @"房产";
    vc15.urlString = [self.arrayLists[14] objectForKey:@"urlString"];
    [self addChildViewController:vc15];
    [vc15 release];
    
    TenTableViewController *vc16 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc16.title = @"历史";
    vc16.urlString = [self.arrayLists[15] objectForKey:@"urlString"];
    [self addChildViewController:vc16];
    [vc16 release];
    
    TenTableViewController *vc17 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc17.title = @"足球";
    vc17.urlString = [self.arrayLists[16] objectForKey:@"urlString"];
    [self addChildViewController:vc17];
    [vc17 release];
    
    TenTableViewController *vc18 = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc18.title = @"游戏";
    vc18.urlString = [self.arrayLists[17] objectForKey:@"urlString"];
    [self addChildViewController:vc18];
    [vc18 release];
    

    
}

- (void)addviewController:(int)nbr title:(NSString *)title{
    TenTableViewController *temp = [[TenTableViewController alloc]initWithStyle:UITableViewStylePlain];
    temp.title = title;
    temp.urlString = [self.arrayLists[nbr] objectForKey:@"urlString"];
    [self addChildViewController:temp];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.mainScrollview.frame.size.width;
    // 滚动标题栏

    TenHeaderLable *titlelable = (TenHeaderLable *)self.headerScrollview.subviews[index];
    
    CGFloat offsetx = titlelable.center.x - self.headerScrollview.frame.size.width * 0.5;
    CGFloat offsetMax = self.headerScrollview.contentSize.width - self.headerScrollview.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if(offsetx > offsetMax){
        offsetx = offsetMax;}
//    CGPoint offset = CGPointMake(offsetx, self.headerScrollview.contentOffset.y);
//    [self.headerScrollview setContentOffset:offset animated:YES];
    //添加控制器
    TenTableViewController *tableview = self.arr[index];
    tableview.index = index;
    [self.headerScrollview.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            self.temlable = self.headerScrollview.subviews[idx];
            //   self.temlable.scale = 0.2;
            self.temlable.backgroundColor = [UIColor clearColor];
        }
        
    }];
    
    tableview.view.frame = scrollView.bounds;
    [self.mainScrollview addSubview:tableview.view];
    self.mainScrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.arr.count, 0);
    
}
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}


//正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (UIView *aview in self.headerScrollview.subviews) {
        if ([aview.class isEqual:[UIImageView class]]) {
            [aview removeFromSuperview];
        }
    }
    
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;

    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1- scaleRight;
    TenHeaderLable *lableleft = self.headerScrollview.subviews[leftIndex];
    
    
    for (UIView *aview in self.headerScrollview.subviews) {
        NSLog(@"%@",aview.class);
    }
    
    lableleft.scale = scaleLeft;
    //移除UIscroview的滚动条
    if (rightIndex < self.headerScrollview.subviews.count) {
        
        TenHeaderLable *labelRight = self.headerScrollview.subviews[rightIndex];
        labelRight.scale = scaleRight;
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
