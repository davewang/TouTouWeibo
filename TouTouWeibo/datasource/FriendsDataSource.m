//
//  FriendsDataSource.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "FriendsDataSource.h"
#import "AttentionList.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
@implementation FriendsDataSource

- (void)loadRecentUsers {
	
	if (  userId <= 0) { 
		return;
	}
	insertPosition = 0;
//@dave	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(usersDidReceive:obj:)];
//	[weiboClient getFriends:userId cursor:0 count:downloadCount];
    //ASIFormDataRequest *request
    
    
    type = Relationship_ATTENTION;
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : ATTENTION_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [request setPostValue:@"1" forKey:@"pageNo"];
    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request setDelegate:self];
    [request startAsynchronous ];
//    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
//    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
//    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
//    if (range.location == NSNotFound ) {
//        // 如果 成功
//        //accont = [Account AccountWithNSDictionary:dictionary];
//        //NSLog(@"jsondata ->%@",jsonData);
//        //[data addObjectsFromArray:list.weiboList];
//        NSLog(@"accont.nickname---->%@",[accont nickname]);
//        
//    } else { 
//        // 如果 失败 
//        
//    }
    
   // ATTENTION_URL
    
	[loadCell.spinner startAnimating];
}



- (void)loadMoreUsersAtPosition:(int)insertPos {
//@dave	if (weiboClient) {
//		[weiboClient release];
//		weiboClient = nil;
//	}		 
	insertPosition = insertPos;
	[loadCell.spinner startAnimating];
//@dave	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(usersDidReceive:obj:)];
//	[weiboClient getFriends:userId cursor:cursor count:downloadCount];
	[loadCell.spinner startAnimating];
}


@end
