//
//  AppDelegate.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//
  
#import "DWUITabBarController.h"

#import "NewDirectMessageViewController.h"
#import "ComposeViewController.h"
#import <UIKit/UIKit.h>
#import "WeiBoModel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,NewDirectMessageViewControllerDelegate> {
  
    BOOL connectionStatus;
    DWUITabBarController *customTabBar;
    UIViewController *rootViewController;
    UINavigationController *homeViewController;
    BOOL userSignined;
    
	NewDirectMessageViewController *newDirectMessageViewController;
    ComposeViewController *composeView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DWUITabBarController *customTabBar;

@property (nonatomic, retain) IBOutlet UINavigationController *homeViewController;

@property (nonatomic, retain) IBOutlet NewDirectMessageViewController *newDirectMessageViewController;
@property (nonatomic, retain) IBOutlet ComposeViewController *composeView;
//+(AppDelegate*)getAppDelegate;
//
+ (void) increaseNetworkActivityIndicator;
+ (void) decreaseNetworkActivityIndicator;

+(AppDelegate*)getAppDelegate;

- (void)signIn;
-(void)logOut;
- (void)alert:(NSString*)title message:(NSString*)message;
-(void)newDM;

- (void)composeNewTweet;
//
//- (void)signIn:(WeiboAccount *)user;
//- (void)signOut;
//- (void)closeAuthenticateView;
//- (void)openAuthenticateView;
//
//- (void)refresh;
//
//- (void)composeNewTweet;
//
- (void)replyTweet:(WeiBoModel *)status ;//comment:(Comment *)comment;
//
- (void)retweet:(WeiBoModel*)status;
//
//- (void)loadDraft:(Draft *)draft;
//
//- (void)newDM;
//
//- (void)advise;

@end

