//
//  MoreUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h"
#import "ChangePasswordUIViewController.h"
@interface MoreUIViewController : BaseUIViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *data;
    UITableView *_tableView;
    NSArray *imageNames;
}
@property(nonatomic,retain)IBOutlet  UITableView *tableView;

@end
