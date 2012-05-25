//
//  ContactsUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-16.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModeViewController.h"
typedef  enum{
    ContactSearchMode,
    ContactListMode,
}ContactMode;
@interface ContactsUIViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate,UIActionSheetDelegate,UISearchBarDelegate>
{
    
    
     
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _moreLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentPageNo;
    NSMutableArray *data;  
    NSMutableArray *searchResult;  
    
    NSString  *userId;
    NSString *currentOrderType;  
    NSString *cityId;
    ContactMode mode;
    
}
@property(retain,nonatomic)NSString *userId;

@property(retain,nonatomic)NSString *cityId;
@property(retain,nonatomic) IBOutlet UITableView *tableView;


@end
