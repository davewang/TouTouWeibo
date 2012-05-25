//
//  ReplyList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reply.h"
#import "Page.h"
@class MessageReplyList;
@interface ReplyList : NSObject {
	NSString *err;
	NSMutableArray *replyInfo;
	Page *pageInfo;
}
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSMutableArray * replyInfo;
@property(retain,nonatomic) Page *pageInfo;
+(ReplyList*)ReplyListWithNSDictionary:(NSDictionary*)_dic;
+(ReplyList*)ReplyListWithMessageReplyList:(MessageReplyList *)_ml;
@end
