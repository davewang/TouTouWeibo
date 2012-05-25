//
//  UserTabBarController.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "UserProfileViewController.h"

@class FriendsViewController;
@class FollowersViewController;
@class UserTimelineController;
@interface UserTabBarController : UITabBarController {
	UserProfileViewController *userProfileViewController;
	FriendsViewController *friendsViewController;
	FollowersViewController *followersViewController;
	UserTimelineController *userTimelineController;
	AccountInfo *user;
}

@property (nonatomic, retain) AccountInfo *user;
//@property (nonatomic, retain) IBOutlet UserProfileViewController *userProfileViewController;

- (void)loadUser:(AccountInfo *)user;
- (void)loadUserByScreenName:(NSString *)screenName;

- (id)initWithoutNib;
- (void)navigationToTop:(id)sender;


@end
