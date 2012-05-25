//
//  Friend.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"


@implementation Friend
@synthesize friendName,friendId,checked,headphoto;
+(Friend*)FriendWithNSDictionary:(NSDictionary *)_dic
{
	Friend *friend = [[Friend alloc] init];
	friend.friendName = [_dic objectForKey:@"friendName"];
	friend.friendId = [_dic objectForKey:@"friendId"];
    friend.headphoto = [_dic objectForKey:@"headphoto"];  
	return friend;
}

@end
