//
//  VideoViewController.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "VideoViewController.h"
#import  "Header.h"
#import "ListenModel.h"
#import "ListenNormalTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WeatherViewController.h"

#import "DataBaseManager.h"
#import "CollectModel.h"
#import "HSDatePickerViewController.h"
#import "ViewController.h"
#import "LOC.h"
#import "KVNProgress.h"



@interface VideoViewController ()<UITableViewDelegate, UITableViewDataSource,HSDatePickerViewControllerDelegate>

@property (nonatomic, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, nonatomic)UIView *contentView;
@property(nonatomic, retain)UISegmentedControl *segmentedControl;


@end

@implementation VideoViewController

-(void)loadView
{
    [super loadView];
    [self creteLivingButton];
    [self createlistenTableView];
    [self tableNetRequest];
    self.date = [self getNowTime];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.view setBackgroundColor:[UIColor grayColor]];
    // 自定义导航栏返回按钮
}

- (NSDate *)getNowTime
{
    NSDate *now = [NSDate date];
    return now;
}

#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    //    dateFormater.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    dateFormater.dateFormat = @"yyyy.MM.dd";
    self.dateLabel.text = [dateFormater stringFromDate:date];
    
    self.selectedDate = date;
    self.date = self.selectedDate;
}

//optional
- (void)hsDatePickerDidDismissWithQuitMethod:(HSDatePickerQuitMethod)method {
    
}

//optional
- (void)hsDatePickerWillDismissWithQuitMethod:(HSDatePickerQuitMethod)method {
    
    [self searchNewsByDate];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    //[self.titleScroll release];
    [self.datePicker release];
    [self.table release];
    [self.date release];
    [super dealloc];
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.videoList = [NSMutableArray array];
    }
    return  self;
}

#pragma mark -
#pragma mark 创建往期节目
- (void)creteLivingButton
{
   self.segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 49, 100, 25) ];
    [self.segmentedControl insertSegmentWithTitle:@"往期" atIndex:0 animated:YES];
    [self.segmentedControl insertSegmentWithTitle:@"电台" atIndex:1 animated:YES];
    [self.segmentedControl.layer setBorderColor:[[UIColor whiteColor] CGColor]];
       self.segmentedControl.momentary = YES;
    self.segmentedControl.multipleTouchEnabled=NO;
    
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, nil]] forState:UIControlStateNormal];
    
    [self.segmentedControl addTarget:self action:@selector(SelectSeg) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:self.segmentedControl];
   LocButton *Now = [[LocButton alloc] initWithFrame:CGRectMake(WIDTH - 60, 0, 50, 20)];
    [Now addTarget:self action:@selector(NowClick:) forControlEvents:UIControlEventTouchUpInside];
    [Now.loc setText:[LOC readLoc]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:Now]];
}

-(void)SelectSeg{
    NSInteger Index = self.segmentedControl.selectedSegmentIndex;
    NSLog(@"index %ld", Index);
    switch (Index) {
        case 0:{
            HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
            hsdpvc.delegate = self;
            if (self.selectedDate) {
                hsdpvc.date = self.selectedDate;
                
            }
            [self presentViewController:hsdpvc animated:YES completion:nil];
        }
            break;
        case 1:
        {
            ViewController *vc = [[ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            
            break;
            
        default:
            break;
    }
}

- (void)NowClick:(id)sender
{
    WeatherViewController *weather = [[WeatherViewController alloc]init];
    [self presentViewController:weather animated:YES completion:nil];
}




#pragma mark - 输入日期，搜索新闻内容（先对self.date进行字符串截取，然后拼接网址，网络请求，加载数据）
- (void)searchNewsByDate
{
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    NSMutableArray *arr =  [dbManager   selectInfoFromNewsCollect];
    
    self.videoList = [NSMutableArray array];
    
    NSString *date = [NSString stringWithFormat:@"%@",self.date];
    NSArray *array = [date componentsSeparatedByString:@" "];
    NSString *str = array[0];
    NSString *year = [str substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [str substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [str substringWithRange:NSMakeRange(8, 2)];
    NSString *pickDate = [NSString stringWithFormat:@"%@%@%@",year,month,day];
    NSLog(@"%@",pickDate);
    
    if ([self isFeatureByPickDate:pickDate]) {
        
        [KVNProgress showErrorWithStatus:@"请确认您输入的日期"];
    }
    else
    {
        AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
        NSString *str1 = [NSString stringWithFormat:@"http://hot.news.cntv.cn/index.php?controller=lanmu&action=getvideolist&id=PAGE1354766409225382&n=50&time=%@",pickDate];
        [manager1 GET:str1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = operation.responseData;
            NSDictionary *BigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *videoListArray = [BigDic objectForKey:@"videoList"];
            for (NSMutableDictionary *smallDic  in videoListArray) {
                ListenModel *model = [[ListenModel alloc]init];
                model.title = [smallDic objectForKey:@"videoTitle"];
                model.image = [smallDic objectForKey:@"videoImage"];
                model.videoID = [smallDic objectForKey:@"videoPlayID"];
                
                [self.videoList addObject:model];
                for (CollectModel *find in arr) {
                    if ([model.title isEqualToString:find.title]) {
                        model.collectioned = YES;
                    }
                }
            }
            [self.table reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    }
    
}


#pragma mark -
#pragma mark 判断是否超过当前日期

- (BOOL)isFeatureByPickDate:(NSString *)pickDate
{
    NSString *yea = [pickDate substringWithRange:NSMakeRange(0, 3)];
    NSString *mont = [pickDate substringWithRange:NSMakeRange(4, 2)];
    NSString *da = [pickDate substringWithRange:NSMakeRange(6, 2)];
    int year = [yea intValue];    int month = [mont intValue];   int day = [da intValue];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int YEAR = (int) dateComponent.year;    int MONTH = (int) dateComponent.month;   int DAY = (int) dateComponent.day;
    if (year > YEAR){
        
    }
    else if (month > MONTH)
    {
        
    }
    else if (day > DAY)
    {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark 创建收听界面的tableView
-(void)createlistenTableView
{
    float x = WIDTH / 2 + 50;
    self.table = [[UITableView alloc]initWithFrame:CGRectMake( 0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    [self.table setRowHeight:x];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

//tableView两个必须实现的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellnormal = @"cellnormal";
    
    ListenModel *model = [self.videoList objectAtIndex:indexPath.row];
    
    ListenNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnormal];
    if (!cell) {
        cell = [[ListenNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellnormal];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.collectButton.listen = model;
    cell.titleLable.text = model.title;
    [cell.cellImage  sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"placeHold.jpg"] options:SDWebImageRetryFailed];
    
    cell.model = model;
    
    CollectModel *collect = [[CollectModel alloc]init];
    collect.title = model.title;
    [cell.collectButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    
    if (model.collectioned) {
        [cell.collectButton setImage:[UIImage imageNamed:@"finishshoucang.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

//tableView的网络请求
-(void)tableNetRequest
{
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    NSMutableArray *arr =  [dbManager   selectInfoFromNewsCollect];
    
    // NSString *str1 = [NSString stringWithFormat:@"http://gslb.hfy.bestvcdn.com/live/program/_hfyd-1_/live/cctv1hd/live.m3u8?se=anhui&ct=2"];
    // 正确的网址
    NSString *str1 = [NSString stringWithFormat:@"http://hot.news.cntv.cn/index.php?controller=lanmu&action=getlastvideolist&id=PAGE1354766409225382&n=50"] ;
    
    [manager1 GET:str1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        NSDictionary *BigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *videoListArray = [BigDic objectForKey:@"videoList"];
        for (NSMutableDictionary *smallDic  in videoListArray) {
            ListenModel *model = [[ListenModel alloc]init];
            model.title = [smallDic objectForKey:@"videoTitle"];
            model.image = [smallDic objectForKey:@"videoImage"];
            model.videoID = [smallDic objectForKey:@"videoPlayID"];
            [self.videoList addObject:model];
            for (CollectModel *find in arr) {
                if ([model.title isEqualToString:find.title]) {
                    model.collectioned = YES;
                }
            }
            
        }
        [self.table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark -
#pragma maek 点击cell在当前cell的位置创建播放界面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.streamPlayer) {
        
        [self.streamPlayer.view removeFromSuperview];
    }
    UITableViewCell *cell =   [tableView cellForRowAtIndexPath:indexPath];
    
    int  x = cell.frame.origin.x;
    int y = cell.frame.origin.y;
    
    ListenModel *model = [self.videoList objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"http://asp.cntv.lxdns.com/asp/hls/200/0303000a/3/default/%@/200.m3u8",model.videoID];
    
    NSURL *streamURL = [NSURL URLWithString:str];
    self.streamPlayer = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];
    [self.streamPlayer.view setFrame:self.view.bounds];
    self.streamPlayer.controlStyle =MPMovieControlStyleEmbedded;
    
    [self.streamPlayer.view setFrame:CGRectMake(x, y,cell.frame.size.width,cell.frame.size.width/2)];
    [self.table addSubview: self.streamPlayer.view];
        [self.streamPlayer play];

    CollectModel *collModel =  [[CollectModel alloc]init];
    collModel.ima = model.image;
    collModel.title  =model.title;
    collModel.mediaUrl = str ;
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    [dbManager insertInfoWithNewsHistory:collModel];
}

- (void)viewWillDisappear:(BOOL)animated

{
    [self.streamPlayer stop];
    [self.streamPlayer.view removeFromSuperview];
}





@end
