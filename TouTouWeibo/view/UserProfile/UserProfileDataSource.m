//
//  UserProfileDataSource.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-11.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "UserProfileDataSource.h"
#import "NSDictionaryAdditions.h"
#import "UpdateUserProfileViewController.h"
#define VActionBtnWith  100
@interface UserProfileDataSource (Private)

- (void)cancelLoadUser;

@end

@implementation UserProfileDataSource
@synthesize user;
@synthesize dataSourceDelegate;
@synthesize tableView;

- (id)initWithTableView:(UITableView *)_userTableView {
	if (self = [super init]) {
		tableView = [_userTableView retain];
		//loadUserClient = nil;
		//loadFriendshipClient = nil;
		tableView.delegate = self;
		tableView.dataSource = self;
		loadStatus = UserProfileLoading;
		
		userProfileHeaderView = [[UserProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, _userTableView.frame.size.width, 72)];
       		detailCellFont = [[UIFont systemFontOfSize:17] retain];
		cellFont = [[UIFont systemFontOfSize:15]retain];
	}
	return self;
	
}
 

- (void)setTableView:(UITableView *)_tableView {
	if (tableView != _tableView) {
		[tableView release];
		tableView = [_tableView retain];
		tableView.dataSource = self;
		tableView.delegate = self;
		[tableView reloadData];
	}
}


- (void)cancelLoadUser {
//	loadUserClient.delegate = nil;
//	[loadUserClient release];
//	loadUserClient = nil;
}

- (void)cancelLoadFriendshipClient {
//	loadFriendshipClient.delegate = nil;
//	[loadFriendshipClient release];
//	loadFriendshipClient = nil;
}

- (void)cancelFollowClient {
//	followClient.delegate = nil;
//	[followClient release];
//	followClient = nil;
}


- (void)dealloc {
	[tableView release];
	tableView = nil;
	[self cancelLoadUser];
	[self cancelLoadFriendshipClient];
	[self cancelFollowClient];
	[userProfileHeaderView release];
	[user release];
	user = nil;
	[detailCellFont release];
	[cellFont release];

	[super dealloc];
}

- (void)setUser:(AccountInfo *)newUser {
	if (user != newUser) {
		[user release];
		user = [newUser retain];
		userProfileHeaderView.user = user;
	}
}

- (void)loadFriendship {
//	[self cancelLoadFriendshipClient];
//	loadFriendshipClient = [[WeiboClient alloc] initWithTarget:self 
//														action:@selector(friendshipDidReceive:obj:)];
//	
//	[loadFriendshipClient getFriendship:user.userId];
}

- (void)loadUser:(AccountInfo *)_user {
	if (user != _user) {
		[self cancelLoadUser];
		self.user = _user;
		loadStatus = UserProfileLoadSuccessful;
		needsCheckFriendship = YES;
		[self loadFriendship];
		[tableView reloadData];
	}
}


- (void)loadUserByUserId:(int)userId {
//	[self cancelLoadUser];
//	[self cancelLoadFriendshipClient];
//	Account *localUser = [Account userWithId:userId];
//	if (localUser) {
//		if (dataSourceDelegate) {
//			[dataSourceDelegate userLoaded:localUser];
//		}
//		loadStatus = UserProfileLoadSuccessful;
//		needsCheckFriendship = YES;
//		self.user = localUser;
//		[self loadFriendship];
//		[tableView reloadData];
//	}
//	else {
//		loadStatus = UserProfileLoading;
//		needsCheckFriendship = NO;
//		self.user = nil;
// 
//		[tableView reloadData];
//	}
}

- (void)loadUserByScreenName:(NSString *)screenName {
//	[self cancelLoadUser];
//	[self cancelLoadFriendshipClient];
//	Account *localUser = [Account userWithScreenName:screenName];
//	if (localUser) {
//		if (dataSourceDelegate) {
//			[dataSourceDelegate userLoaded:localUser];
//		}
//		loadStatus = UserProfileLoadSuccessful;
//		needsCheckFriendship = YES;
//		self.user = localUser;
//		[self loadFriendship];
//		[tableView reloadData];
//	}
//	else {
//		loadStatus = UserProfileLoading;
//		needsCheckFriendship = NO;
//		self.user = nil;
// 
//		[tableView reloadData];
//	}
}
 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	if (loadStatus == UserProfileLoadSuccessful) {
		return 2;
	}
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (loadStatus == UserProfileLoadSuccessful) {
		switch (section) {
		 
			case 0:
				return 2;
			case 1:
				return 3;
		}	
	}
    else if (loadStatus == UserProfileLoading) {
		return 1;
	}
	else if (loadStatus == UserProfileLoadFailed) {
		return 1;
	}
	
	
	return 0;
}

- (UITableViewCell*)loadingCell {
	static NSString *loadingCellIdentifier = @"LoadingCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingCellIdentifier] autorelease];
		UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[cell addSubview:spinner];
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
		spinner.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
		[spinner startAnimating];
		[spinner release];
	}
	return cell;
}

- (UITableViewCell*)userProfileCell:(int)row {
	static NSString *CellIdentifier = @"userProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.font = cellFont;
		cell.detailTextLabel.font = detailCellFont;
		cell.detailTextLabel.numberOfLines = 0;
	} 
    if (row == 0) {
		cell.textLabel.text = @"现居地";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",user.oftenAddressOfProvince,user.oftenAddress];
	}
	else if (row == 1) {
		cell.textLabel.text = @"手机";
		cell.detailTextLabel.text = user.phone;
	}
	return cell;
}

- (UITableViewCell*)userFollowersCell:(int)row {
	static NSString *CellIdentifier = @"userFollowersCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.font = cellFont;
		cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:17];
		cell.detailTextLabel.numberOfLines = 0;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (row == 0) {
		cell.textLabel.text = @"关注";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.attentionCount];
	}
	else if (row == 1) {
		cell.textLabel.text = @"粉丝";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.fanCount];
	}
	else if (row == 2) {
		cell.textLabel.text = @"微博";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.weiboCount];
	}
	return cell;
}

- (UITableViewCell*)followUnfollowCell:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"followUnfollowCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}
	 
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (loadStatus == UserProfileLoadSuccessful 
		&& indexPath.section == 1) {
		CGFloat detailLabelWidth = 207;
		CGSize size;
		if (indexPath.row == 0) {
			size = [user.descirption  sizeWithFont:detailCellFont  
								constrainedToSize:CGSizeMake(detailLabelWidth, 9999)];
		}
		else if (indexPath.row == 1) {
			size = [user.oftenAddressOfProvince sizeWithFont:detailCellFont  
							 constrainedToSize:CGSizeMake(detailLabelWidth, 9999)];
		}
		else if (indexPath.row == 2) {
			size = [user.phone sizeWithFont:detailCellFont  
						constrainedToSize:CGSizeMake(detailLabelWidth, 9999)];
		}
		CGFloat height = size.height + 16;
		if (height < 44) {
			height = 44;
		}
		return height;
	}
	
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (loadStatus == UserProfileLoadSuccessful) {
		if (indexPath.section == 0) {
 	 
            return [self userProfileCell:indexPath.row];
		}
		else 
        if (indexPath.section == 1) {
			return [self userFollowersCell:indexPath.row];
		}
		 
	}
	else if (loadStatus == UserProfileLoading) {
		return [self loadingCell];
	}
	else if (loadStatus == UserProfileLoadFailed) {
		static NSString *loadFailedCellIdentifier = @"loadFailedCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadFailedCellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadFailedCellIdentifier] autorelease];
		}
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.text = errorMessage;
		
		return cell;
	}
	
	
	static NSString *CellIdentifier = @"UserViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.clipsToBounds = YES;
	return cell;
}
-(void)editUserAction
{
   
    [dataSourceDelegate editAction];
      
}
-(void)followAction
{
    [dataSourceDelegate followAction];
}
-(void)unfollowAction
{
      [dataSourceDelegate unfollowAction];
}
-(UIButton*)ButtonForEdit{
    UIButton  *_actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionbtn setTitle:@"编辑" forState:UIControlStateNormal];
    _actionbtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_actionbtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"userinfo_relationship_editprofilebutton_background.png"] forState:UIControlStateNormal];
    _actionbtn.frame = CGRectMake(235,20,70,30);
    [_actionbtn addTarget:self action:@selector(editUserAction) forControlEvents:UIControlEventTouchUpInside];
    return _actionbtn;
} 
-(UIButton*)ButtonForfollow{
    UIButton  *_actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionbtn setTitle:@"关注" forState:UIControlStateNormal];
    _actionbtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_actionbtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"userinfo_relationship_followbutton_background.png"] forState:UIControlStateNormal];
    _actionbtn.frame = CGRectMake(235,20,70,30);
    [_actionbtn addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
    return _actionbtn;
} 
-(UIButton*)ButtonForunfollow{
    UIButton  *_actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionbtn setTitle:@"取消关注" forState:UIControlStateNormal];
    _actionbtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_actionbtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"userinfo_relationship_unfollowbutton_background.png"] forState:UIControlStateNormal];
    _actionbtn.frame = CGRectMake(235,20,70,30);
    [_actionbtn addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
    return _actionbtn;
} 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (user && loadStatus == UserProfileLoadSuccessful && section == 0) {
         if ([user.uId intValue] ==[[GlobalInfo sharedGlobalInfo].userId intValue]) {
            [userProfileHeaderView addSubview: [self ButtonForEdit] ];
        }else if([user.relation intValue ] ==0)
        {
              [userProfileHeaderView addSubview: [self ButtonForfollow] ];
        }else if([user.relation intValue ] ==1){
             [userProfileHeaderView addSubview: [self ButtonForunfollow] ];
        }
        return userProfileHeaderView;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (user && loadStatus == UserProfileLoadSuccessful && section == 0) {
        return userProfileHeaderView.frame.size.height;
    }
    else {
        return 0;
    }
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (loadStatus == UserProfileLoadSuccessful) {
	 
		if (indexPath.section == 1) {
			if (indexPath.row == 0) {
				[dataSourceDelegate showFriends];
			}
			else if (indexPath.row == 1) {
				[dataSourceDelegate showFollowers];
			}
			else if (indexPath.row == 2) {
				[dataSourceDelegate showStatus];
			}
		}
	}
        [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
}

- (void)actionSheet:(UIActionSheet*)actionSheet 
clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet.tag == 99) {
		if (buttonIndex == 0) {
			[self cancelFollowClient];
//			followClient = [[WeiboClient alloc] initWithTarget:self 
//														action:@selector(followDidReceive:obj:)];
//			
//			[followClient unfollow:user.userId];
			//user.following = NO;
		}
		[tableView reloadData];
	}
}



@end
