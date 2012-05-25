//
//  UserTimelineController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-4.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h"
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Page.h"
@interface UserTimelineController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *data;
    UITableView *tableView;
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    
    BOOL _moreLoading;
    
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
    
    UIImageView *newStatusNSNotificationView;
    UILabel *newStatuslabelMessage;
    int  currentPageNo;
    
    
}
@property(retain,nonatomic) IBOutlet UITableView *tableView;
-(void)loadCurrentViewData;
@end
