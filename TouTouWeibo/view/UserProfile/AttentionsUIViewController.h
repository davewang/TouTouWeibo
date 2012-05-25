//
//  AttentionsUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-14.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reply.h"
#import "CommentCellViewDoc.h"
#import "TweetCell.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"
#import "DianmingUIViewController.h"
#import "BaseUIViewController.h"
@interface AttentionsUIViewController:BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *tableView;
  	NSMutableArray *friends;  
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

@property(retain,nonatomic) IBOutlet UITableView *tableView;

@property(retain,nonatomic) NSString *userId;

@end
