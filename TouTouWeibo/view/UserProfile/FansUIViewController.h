//
//  FansUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-14.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansUIViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *tableView;
  	  
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _moreLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentPageNo;
    
    
    NSMutableArray *data; 
    id<DianmingUIViewControllerDelegate> dianMingdelegate;
    DianMingType dianmingType;
    NSString  *userId;
    
    NSMutableArray *comments;
	NSMutableDictionary *commentDocs;
  
}
@property(retain,nonatomic)NSString *userId;
@property(retain,nonatomic) IBOutlet UITableView *tableView;

@end

 
