//
//  BaseTableViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-16.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController  : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *tableView;
    
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _moreLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentPageNo;
    
    
    NSMutableArray *data;   
    
    
    NSMutableArray *comments;
	NSMutableDictionary *commentDocs;
    
}
@property(retain,nonatomic)NSString *userId;
@property(retain,nonatomic) IBOutlet UITableView *tableView;

-(void) showWait:(BOOL)visible;

@end
