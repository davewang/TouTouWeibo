//
//  FriendsViewController.h
//  gZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsDataSource.h"
#import "AccountInfo.h"

@interface FriendsViewController : UITableViewController<FriendsFollowersDataSourceDelegate> {
	FriendsDataSource *dataSource;
	AccountInfo *user;
}

@property (nonatomic, retain) AccountInfo *user;

@end
