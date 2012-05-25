//
//  FriendsTimelineViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h"
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Page.h"
#import "ComposeViewController.h"

#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
@class MGAutoSizeButton;
@interface FriendsTimelineViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,WEPopoverControllerDelegate, UIPopoverControllerDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate,WESelectedDelegate>
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
    WEPopoverController *popoverController;
   // Class popoverClass;
    MGAutoSizeButton *button;
    NSString *currentType;
    BOOL isFrist;
    UIActivityIndicatorView *loadingView;
    UIBarButtonItem *loadingViewItem;
    
}
@property(retain,nonatomic) IBOutlet UITableView *tableView;
 

@property (nonatomic, retain) WEPopoverController *popoverController;

-(void)loadCurrentViewData;
-(void)showWait:(BOOL)isShow;
@end
