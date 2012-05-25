//
//  FanList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FanList.h"
#import "Page.h"
#import "FanBean.h"

@implementation FanList
@synthesize err,fanList,pageInfo;

+(FanList*)FanListModelWithNSDictionary:(NSDictionary *)_dic
{
	FanList *fanList = [[FanList alloc] init];
	fanList.err = @"0";
	fanList.fanList =[[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"fanInfo"] )
    { 
        [fanList.fanList addObject:[FanBean FanBeanWithNSDictionary:_tDic]];
    }
	fanList.pageInfo =  [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ];// [_dic objectForKey:@"pageInfo"];
	return fanList;
}

@end
