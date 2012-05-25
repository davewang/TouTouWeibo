//
//  FollowersDataSource.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "FollowersDataSource.h"
#import "AttentionList.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"

@implementation FollowersDataSource

- (void)loadRecentUsers {
	
	if (userId <= 0) { 
		return;
	}
	insertPosition = 0;
    type = Relationship_FAN;
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : FAN_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [request setPostValue:@"1" forKey:@"pageNo"];
    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request setDelegate:self];
    [request startAsynchronous ];
//	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(usersDidReceive:obj:)];
//	[weiboClient getFollowers:userId cursor:0 count:downloadCount];
	
}



- (void)loadMoreUsersAtPosition:(int)insertPos {
//	if (weiboClient) { 
//		[weiboClient release];
//		weiboClient = nil;
//	}		 
	insertPosition = insertPos;
	[loadCell.spinner startAnimating];
//	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(usersDidReceive:obj:)];
//	[weiboClient getFollowers:userId cursor:cursor count:downloadCount];
	
}


@end
