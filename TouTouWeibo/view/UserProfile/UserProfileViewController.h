//
//  UserProfileViewController.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-11.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileDataSource.h"
#import "AttentionsUIViewController.h"
#import "UserTimelineController.h"
#import "FansUIViewController.h"
#import "UpdateUserProfileViewController.h"

@class UserTabBarController;

@interface UserProfileViewController : BaseUIViewController<UserProfileDataSourceDelegate> {
	UserProfileDataSource *dataSource;
	AccountInfo *user;
//	UserTabBarController *userTabBarController;
    UITableView *tableView;
    IBOutlet AttentionsUIViewController *attentons;
    
    IBOutlet FansUIViewController *fans;
    IBOutlet UserTimelineController *userTimeline;
}

@property (nonatomic, retain) AccountInfo* user;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
//@property (nonatomic, assign) UserTabBarController *userTabBarController;

- (void)loadUser:(AccountInfo *)user;
- (void)loadUserByScreenName:(NSString *)screenName;

@end
