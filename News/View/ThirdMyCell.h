//
//  ThirdMyCell.h
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface ThirdMyCell : UITableViewCell
//@property (strong, nonatomic) IBOutlet UIImageView *third1Img;
//@property (strong, nonatomic) IBOutlet UIImageView *third2Img;
//@property (strong, nonatomic) IBOutlet UIImageView *third3Img;
//@property (strong, nonatomic) IBOutlet UILabel *thridTitle;

@property(nonatomic, retain)UIImageView *third1Img;
@property(nonatomic, retain)UIImageView *third2Img;
@property(nonatomic, retain)UIImageView *third3Img;
@property(nonatomic, retain)UILabel *thirdTitle;

@property (nonatomic, retain)NewsModel *nm;

@end
