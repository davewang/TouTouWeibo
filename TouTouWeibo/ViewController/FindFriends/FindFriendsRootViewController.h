//
//  FindFriendsRootViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFriendsRootViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *data;
    UITableView *_tableView;
    NSArray *imageNames;
    NSMutableArray *_findFriendsVCList1;
    NSMutableArray *_findFriendsVCList2;
    UIButton * headButton;
} 

@property(retain,nonatomic) NSArray *_findFriendsVCList1;
@property(retain,nonatomic) NSArray *_findFriendsVCList2;
@property(retain,nonatomic)IBOutlet  UITableView *tableView;

@end
