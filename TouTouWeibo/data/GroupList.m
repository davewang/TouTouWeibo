//
//  GroupList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GroupList.h"


@implementation GroupList
@synthesize err,groupInfo,pageInfo;
+(GroupList*)GroupListWithNSDictionary:(NSDictionary *)_dic
{

	GroupList *gl = [[GroupList alloc] init];
	gl.err = @"0";
	gl.groupInfo = [[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"groupInfo"] )
    { 
        [gl.groupInfo addObject:[Group GroupWithNSDictionary:_tDic]];
    }
    gl.pageInfo =  [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ];
	return gl;
}





@end
