//
//  FriendsDetailViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-10.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendObject.h"
#import "UserProfileHeaderView.h"
@interface FriendsDetailViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>
{
    FriendObject *friendObject;
    UITableView *detailTableView;
    NSMutableArray *_findFriendsVCList;
    NSMutableArray *rowTitleList;
    NSString *friendId;
    UIFont *detailCellFont;
	UIFont *cellFont;
    AccountInfo *user;
    Boolean *isFriend;
    UserProfileHeaderView *userProfileHeaderView;
}
@property(retain,nonatomic) FriendObject *friendObject;
@property(retain,nonatomic)IBOutlet  UITableView *detailTableView;
@property(retain,nonatomic) NSMutableArray *_findFriendsVCList;
@property(retain,nonatomic) NSMutableArray *rowTitleList;

@property(retain,nonatomic) NSString *friendId;
@property(nonatomic) Boolean *isFriend;
@end
