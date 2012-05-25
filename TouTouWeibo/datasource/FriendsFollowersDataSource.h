//
//  FriendsFollowersDataSource.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WeiboClient.h"
#import "LoadMoreCell.h"
#import "UserCell.h"
#import "NSDictionaryAdditions.h"
#import "AccountInfo.h"
 
@protocol FriendsFollowersDataSourceDelegate

- (void)userSelected:(Attention *)user;

@end
enum{
     Relationship_ATTENTION=0,
     Relationship_FAN=1
};
@interface FriendsFollowersDataSource : NSObject<UITableViewDelegate, UITableViewDataSource> {
	id<FriendsFollowersDataSourceDelegate> friendsFollowersDataSourceDelegate;
	UITableView *tableView;
//	WeiboClient *weiboClient;
	NSMutableArray *users;
	LoadMoreCell *loadCell;
	BOOL isRestored;
	BOOL userLoaded;
	int insertPosition;
	int cursor;
	int downloadCount;
	int userId;	
    int type;//是关注还是粉丝
}

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int userId;
@property (nonatomic, assign) BOOL userLoaded;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id<FriendsFollowersDataSourceDelegate> friendsFollowersDataSourceDelegate;

- (id)initWithTableView:(UITableView *)_tableView ;

- (void)loadRecentUsers;

- (void)loadUsers:(int)userId;

- (void)loadMoreUsersAtPosition:(int)insertPos;

- (void)reset;


@end
