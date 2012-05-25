//
//  AttentionList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AttentionList.h"

#import "Attention.h"

@implementation AttentionList
@synthesize err,attentionList,pageInfo;
+(AttentionList*)AttentionListWithNSDictionary:(NSDictionary *)_dic
{
	AttentionList *attentionList = [[AttentionList alloc] init];
	
	attentionList.err = @"0";
	attentionList.attentionList =[[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"attentionInfo"] )
    { 
        [attentionList.attentionList addObject:[Attention AttentionWithNSDictionary:_tDic]];
    }
	attentionList.pageInfo =   [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ];// [_dic objectForKey:@"pageInfo"];
	return attentionList;
}


@end
