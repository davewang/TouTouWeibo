//
//  FoundResultViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-10.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundResultViewController :  BaseUIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *imageNames;
    NSMutableArray *_findFriendsList;
    NSString *findType;
}

@property(retain,nonatomic) NSArray *_findFriendsList;
@property(nonatomic,retain) NSString *findType;
@property(retain,nonatomic)IBOutlet  UITableView *tableView;

@end
