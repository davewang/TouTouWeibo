//
//  ShakeFrinedsViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerView.h"
#import "AccelerometerHelper.h"
@interface ShakeFrinedsViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource,AccelerometerHelperDelegate>
{
    DrawerView * drawer;
}
@property (nonatomic,retain)DrawerView * drawer;
@property (nonatomic,retain) IBOutlet UIView * upView;
@property (nonatomic,retain) IBOutlet UIView * downView;
@property (nonatomic,retain) IBOutlet UIView * shakeView;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView * activityView;
@property (nonatomic,retain) IBOutlet UILabel * failLabel;

@end

