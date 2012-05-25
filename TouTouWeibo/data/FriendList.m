//
//  FriendList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendList.h"
#import "Friend.h"

@implementation FriendList
@synthesize err,friendInfo,pageInfo;
//+(FriendList)FriendListWithNSDictionary:(NSDictionary *)_dic
//{
//	FriendList *list = [[FriendList alloc] init];
//	list.err = @"0";
//	list.friendInfo = =[[NSMutableArray alloc] initWithCapacity:2];
//	for(NSDictionary *_tDic in [_dic objectForKey:@"fanInfo"] )
//    { 
//        [list.friendInfo addObject:[Friend FriendWithNSDictionary:_tDic]];
//    }
//	return list;
//
//}

+(FriendList*)FriendListWithNSDictionary:(NSDictionary*)_dic{

    FriendList *list = [[FriendList alloc] init];
	list.err = @"0";
	list.friendInfo = [[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"friendInfo"] )
    { 
        [list.friendInfo addObject:[Friend FriendWithNSDictionary:_tDic]];
    }
    list.pageInfo =  [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ];
	return list;
}


@end
