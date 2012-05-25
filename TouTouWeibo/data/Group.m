//
//  Group.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Group.h"


@implementation Group
@synthesize groupId,groupName;
+(Group*)GroupWithNSDictionary:(NSDictionary *)_dic
{
	Group *g = [[Group alloc] init];
	g.groupId = [_dic objectForKey:@"groupId"];
	g.groupName = [_dic objectForKey:@"groupName"];
	return  g;
}

@end
