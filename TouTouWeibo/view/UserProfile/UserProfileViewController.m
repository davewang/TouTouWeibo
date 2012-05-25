//
//  UserProfileViewController.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-11.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "UserProfileViewController.h"


@implementation UserProfileViewController
@synthesize user;
@synthesize tableView;
//@synthesize userTabBarController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataSource = [[UserProfileDataSource alloc]initWithTableView:self.tableView];
		dataSource.dataSourceDelegate = self;
    }
    return self;
}

 
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		dataSource = [[UserProfileDataSource alloc]initWithTableView:self.tableView];
		dataSource.dataSourceDelegate = self;
	}
	return self;
}
-(void)doCompose{
 [[AppDelegate getAppDelegate] composeNewTweet];
}
-(void)refreshUser{
    [self loadUser:[CommonUtils loadAccountByUId:[GlobalInfo sharedGlobalInfo].userId]];
}
-(void)backHome{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setNeedsDisplay1 ];
	dataSource.tableView = self.tableView;
    
    if ([[GlobalInfo sharedGlobalInfo].userId  intValue]  == [user.uId intValue]) {
        [self setViewControllerTitle: @"我的资料"];
        
       
            if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[UserProfileViewController class]]) {
                 [self leftBackBtnWithImageName:@"navigationbar_compose.png" imageHighlightedName:@"navigationbar_compose_highlighted.png" andAction:@selector(doCompose)];  
            }
            else{
                [self leftBackBtnWithAction:@selector(actionBack)];
            }
      
        
      
        [self rightBtnWithImageName:@"navigationbar_refresh.png" imageHighlightedName:@"navigationbar_refresh_highlighted.png" andAction:@selector(refreshUser) ]; 
        
    }else{ 
        [self setViewControllerTitle: @"资料"];
        [self leftBackBtnWithAction:@selector(actionBack)];
        [self rightBackHomeBtnWithAction:@selector(backHome)];
    }
 
    
     
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[GlobalInfo sharedGlobalInfo].userId  intValue]  == [user.uId intValue])
               [self refreshUser];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setUser:(AccountInfo *)_user {
	if (user != _user) {
		[user release];
		user = [_user retain];
	}
}

- (void)userLoaded:(AccountInfo *)_user {
	self.user = _user;
	//[userTabBarController setUser:_user];
}

- (void)loadUserByScreenName:(NSString *)screenName {
	//self.parentViewController.title = screenName;
	[dataSource loadUserByScreenName:screenName];
}

- (void)loadUser:(AccountInfo *)_user {
	self.user = _user;
	//self.parentViewController.title = _user.name;
	[dataSource loadUser:_user];
}

- (void)showFriends {
	//self.tabBarController.selectedIndex = 1;
    NSLog(@"showFriends");
    [self.navigationController pushViewController:attentons animated:YES];
    attentons.userId = user.uId;
}

- (void)showFollowers {
	//self.tabBarController.selectedIndex = 2;
     NSLog(@"showFollowers");
     [self.navigationController pushViewController:fans animated:YES];
     fans.userId = user.uId;
}

- (void)showStatus {
	//self.tabBarController.selectedIndex = 3;
    [self.navigationController pushViewController:userTimeline animated:YES];
      NSLog(@"showStatus");
}

-(void)editAction
{
  UpdateUserProfileViewController *update =  [[UpdateUserProfileViewController alloc] init];
    update.account = user;
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:update];
    [self.navigationController presentModalViewController:nav  animated:YES];
      
}
-(void)followAction
{
    Bean *b = [CommonUtils addAttention:user.uId];
    if ([b.err intValue]!=0) {
        [CommonUtils ShowErroringInView:self.view WithErrorMessage:b.msg];
    }else{
        [CommonUtils ShowErroringInView:self.view WithErrorMessage:b.msg];
    }
    
}
-(void)unfollowAction
{
    Bean *b = [CommonUtils delAttention:user.uId];
    if ([b.err intValue]!=0) {
        [CommonUtils ShowErroringInView:self.view WithErrorMessage:b.msg];
    }else{
        [CommonUtils ShowErroringInView:self.view WithErrorMessage:b.msg];
    }
    
}

- (void)dealloc {
	[dataSource release];
    [super dealloc];
}


@end
