//
//  AppDelegate.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginUIViewController.h"
#import "CostomNavgationBar.h"
//#import "Reachability2.h"

static int NetworkActivityIndicatorCounter = 0;

@implementation AppDelegate
 
@synthesize window = _window;
@synthesize customTabBar;
@synthesize homeViewController;
@synthesize composeView;
@synthesize newDirectMessageViewController;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    userSignined = NO;
    [self.window addSubview:homeViewController.view];
    rootViewController = homeViewController;
    [self.window makeKeyAndVisible];
   // [self.window makeKeyWindow];
   // NSLog(@"keyWindow = %@",[[UIApplication sharedApplication] keyWindow]);
    return YES;
}
- (void)signIn {
    userSignined = YES;
	[rootViewController dismissModalViewControllerAnimated:YES];
	[homeViewController.view removeFromSuperview];
    
	[customTabBar.view removeFromSuperview];
     customTabBar.selectedIndex = 0;
    [customTabBar reloadFriendsTimeLine];
    [customTabBar reloadFriendsAboutWithMe];
    
    [customTabBar viewDidLoad];
	[self.window addSubview:customTabBar.view];
	rootViewController = customTabBar;
    
	//addAccountView = nil;
	//[self postInit];
}
-(void)logOut{
    if (userSignined) {
        [rootViewController dismissModalViewControllerAnimated:YES];
        [homeViewController.view removeFromSuperview];
        [customTabBar.view removeFromSuperview];
         
        [self.window addSubview:homeViewController.view ];
        rootViewController = homeViewController;
        userSignined = NO;
    } 

}
- (void)newDM {
	[customTabBar presentModalViewController:newDirectMessageViewController animated:YES];
}



- (void)composeNewTweet {
	[customTabBar presentModalViewController:composeView animated:YES];
	[composeView composeNewTweet];
}

- (void)replyTweet:(WeiBoModel *)status// comment:(Comment *)comment
{
	[customTabBar presentModalViewController:composeView animated:YES];
	[composeView replyTweet:status ];//comment:comment];
}

- (void)retweet:(WeiBoModel*)status {
    [customTabBar presentModalViewController:composeView animated:YES];
	[composeView retweet:status];
}
+ (void) increaseNetworkActivityIndicator
{
	if (NetworkActivityIndicatorCounter < 0) {
		NetworkActivityIndicatorCounter = 0;
	}
	NetworkActivityIndicatorCounter++;
	BOOL preVisible = [UIApplication sharedApplication].networkActivityIndicatorVisible;
	if (!preVisible) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NetworkActivityIndicatorCounter > 0;
	}
}

+ (void) decreaseNetworkActivityIndicator
{
	if (NetworkActivityIndicatorCounter > 0) {
		NetworkActivityIndicatorCounter--;
	}
	BOOL preVisible = [UIApplication sharedApplication].networkActivityIndicatorVisible;
	if (preVisible && NetworkActivityIndicatorCounter <= 0) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NetworkActivityIndicatorCounter > 0;
	}
}
 
+(AppDelegate*)getAppDelegate{
     return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

#pragma mark -
#pragma mark Alert

static UIAlertView *sAlert = nil;

- (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;
    
    sAlert = [[UIAlertView alloc] initWithTitle:title
                                        message:message
									   delegate:self
							  cancelButtonTitle:@"Close"
							  otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde
{
    sAlert = nil;
}

@end  