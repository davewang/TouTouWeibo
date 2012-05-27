//
//  FoundResultViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-10.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFriendListBean.h"
#import "ContactCell.h"
#import "MapModeViewController.h"

@interface FoundResultViewController :  BaseUIViewController<UITableViewDelegate,UITableViewDataSource,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *_tableView;
    NSArray *imageNames;
    NSMutableArray *data;
    NSString *findType;
    NSString *findValues;
    NSString *proviceName;
    NSString *cityName;
    NSString *cityId;
    CommonFriendListBean *friendList;
    
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _moreLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentPageNo;
}

@property(retain,nonatomic) NSArray *_findFriendsList;
@property(nonatomic,retain) NSString *findType;
@property(retain,nonatomic)IBOutlet  UITableView *tableView;
@property(nonatomic,retain) NSString *findValues;
@property(nonatomic,retain) NSString *proviceName;
@property(nonatomic,retain) NSString *cityName;
@property(nonatomic,retain) NSString *cityId;
@property(nonatomic,retain) CommonFriendListBean *friendList;

@end
