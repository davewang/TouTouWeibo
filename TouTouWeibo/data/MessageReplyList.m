//
//  MessageList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageReplyList.h"

#import "MessageReply.h"

@implementation MessageReplyList
@synthesize err,weiboList,pageInfo;
+(MessageReplyList*)MessageListWithNSDictionary:(NSDictionary *)_dic
{
	MessageReplyList *ml = [[MessageReplyList alloc] init];
	ml.err = @"0";
	ml.weiboList = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [_dic objectForKey:@"weiboList"] )
    { 
         [ml.weiboList addObject:[MessageReply   MessageWithNSDictionary:_tDic]];
    }
    
    ml.pageInfo =  [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"]];
	return ml;
}
 


@end
