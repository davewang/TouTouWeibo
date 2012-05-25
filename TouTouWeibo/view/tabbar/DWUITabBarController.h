//
//  DWUITabBarController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-30.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileViewController.h"
#import "FriendsTimelineViewController.h"
#import "FriendsAboutWithMeViewController.h"
@interface DWUITabBarController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
{   
    UIImageView * lightImageView;
    
    UIImageView * itme1;
    UIImageView * itme2;
    UIImageView * itme3;
    UIImageView * itme4;
    UIImageView * itme5;
    UIImageView * itme6;
    IBOutlet UserProfileViewController *userProfile;
    IBOutlet FriendsTimelineViewController *friendsTimeline;
    IBOutlet FriendsAboutWithMeViewController *friendsAboutWithMe;
}

-(void)reloadFriendsTimeLine;

-(void)reloadFriendsAboutWithMe;

-(void)reloaduserProfile;

@end