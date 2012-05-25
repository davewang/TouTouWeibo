//
//  CommentsTimelineViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-5.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h"
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Page.h"
#import "ReplyList.h"


@interface CommentsTimelineViewController :BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *data;
    UITableView *tableView;
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    
    BOOL _moreLoading;
    
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
    NSString *weiboId;
    UIImageView *newStatusNSNotificationView;
    UILabel *newStatuslabelMessage;
    int  currentPageNo;
    NSMutableArray *comments;
	NSMutableDictionary *commentDocs;
    
    
}
@property(retain,nonatomic) IBOutlet UITableView *tableView;
@property(retain,nonatomic) NSString *weiboId;
-(void)loadCurrentViewData;
@end
