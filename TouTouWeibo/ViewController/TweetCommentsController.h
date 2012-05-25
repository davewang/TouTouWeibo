//
//  TweetCommentsController.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-28.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCommentsDataSource.h"
#import "WeiBoModel.h"

@interface TweetCommentsController : UIViewController<TweetCommentsDataSourceDelegate> {
	PullRefreshTableView *tableView;
	TweetCommentsDataSource *dataSource;
	WeiBoModel *status;
	UIBarButtonItem *replyButton;
}

@property (nonatomic, retain) IBOutlet PullRefreshTableView *tableView;
@property (nonatomic, retain) WeiBoModel *status;

@end
