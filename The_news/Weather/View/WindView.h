//
//  WindView.h
//  ExploreWorld
//
//  Created by dlios on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindView : UIView

@property (nonatomic,retain)UIImageView *pile;      //风扇桩
@property (nonatomic,retain)UIImageView *leaf;       //风扇叶
@property (nonatomic,retain)UILabel *sk_fl;        //风力级别
@property (nonatomic,retain)UILabel *sk_fx;         //风向；
@property (nonatomic,retain)UILabel *sk_fs;         //风速；
@end
