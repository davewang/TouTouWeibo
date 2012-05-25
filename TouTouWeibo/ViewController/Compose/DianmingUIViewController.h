//
//  DianmingUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-13.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Friend.h"
#import "Group.h"
#import "BaseUIViewController.h"
@protocol DianmingUIViewControllerDelegate

- (void) addUserScreenName:(NSString*)userScreenName;

- (void) addGroupIds:(NSString*)groupIds;

@end
typedef enum {
	DianMingTypeUserName,
	DianMingTypeGroupId,
	 
} DianMingType;

@interface DianmingUIViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *tableView;
  	NSMutableArray *friends;  
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _moreLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    int currentPageNo;
    NSMutableArray *dianmingCheckedIndexs;
    
    NSMutableArray *dianmingUnCheckedIndexs;
    NSMutableString *dianmingBuffer;
    id<DianmingUIViewControllerDelegate> dianMingdelegate;
    DianMingType dianmingType;
}

@property(retain,nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) DianMingType dianmingType;

@property(assign,nonatomic)  id<DianmingUIViewControllerDelegate> dianMingdelegate;
@end
