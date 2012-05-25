//
//  ReplyList.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ReplyList.h"

#import "MessageReplyList.h"
@implementation ReplyList

@synthesize err,replyInfo,pageInfo;
+(ReplyList*)ReplyListWithNSDictionary:(NSDictionary *)_dic
{
	ReplyList *rl = [[ReplyList alloc] init];
	rl.err = @"0";
	rl.replyInfo = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [[_dic objectForKey:@"replyInfo"] objectForKey:@"reply"] )
    { 
        
        [rl.replyInfo addObject:[Reply ReplyWithNSDictionary:_tDic]];
    }
    
    rl.pageInfo = [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"]];
	return rl;

    
}
+(ReplyList*)ReplyListWithMessageReplyList:(MessageReplyList *)_ml
{
    ReplyList *rl = [[ReplyList alloc] init];
	rl.err = @"0";
	rl.replyInfo = [[NSMutableArray alloc] initWithCapacity:2];
    for(MessageReply *_tDic in _ml.weiboList  )
    { 
        
        [rl.replyInfo addObject:[Reply ReplyWithMessageReply:_tDic]];
    }
    
    rl.pageInfo = _ml.pageInfo;
    NSLog(@"pageInfo.pageNo=%d",_ml.pageInfo.pageNo);
    
    NSLog(@"pageInfo.sumPage=%d",_ml.pageInfo.sumPage);
    return  rl;
}

@end
