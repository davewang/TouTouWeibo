//
//  DisplayModeSettingUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-27.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
@interface DisplayModeSettingUIViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *data;
    UITableView *_tableView;
    NSArray *imageNames;
    UIImageView *indicatorTick;
    
    int currentCheckInteger;
}
@property(nonatomic,retain)IBOutlet  UITableView *tableView;

@end
