    //
//  FriendsViewController.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "FriendsViewController.h"
#import "UserTabBarController.h"

#import "Attention.h"
#import "CommonUtils.h"
@implementation FriendsViewController
@synthesize user;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)init {
	if(self = [super init]) {
		dataSource = [[FriendsDataSource alloc]initWithTableView:self.tableView];
		dataSource.friendsFollowersDataSourceDelegate = self;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithoutNib {
	if (self = [self init]) {
		
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		
	}
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	dataSource.tableView = self.tableView;
    [super viewDidLoad];
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	if (!dataSource.userLoaded) {
		[dataSource loadRecentUsers];
	}
}

- (void)dealloc {
	[dataSource release];
	[user release];
    [super dealloc];
}

- (void)reset {
	[dataSource reset];
}

- (void)setUser:(AccountInfo *)_user {
	if (user != _user) {
		[user release];
		user = [_user retain];
		[self reset];
		dataSource.userId = [user.uId intValue];
	}
}

- (void)userSelected:(AccountInfo *)_user {
    if ([_user isKindOfClass:[Attention class]]) {
        Attention *att = (Attention*)_user;
        
        _user = [CommonUtils loadAccountByUId:att.attOfUserId];
    }
    NSLog(@"............._user =%@",user);
	UserTabBarController *c = [[[UserTabBarController alloc] initWithoutNib] autorelease];
	[c loadUser:_user];
	[self.parentViewController.navigationController pushViewController:c animated:YES];
}

@end
