//
//  MessageList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageReply.h"
#import "Page.h"

@interface MessageReplyList : NSObject {
	NSString *err;
	NSMutableArray *weiboList;
	Page *pageInfo;
}
@property(retain,nonatomic) NSString *err;
@property(retain,nonatomic) NSMutableArray *weiboList;
@property(retain,nonatomic) Page *pageInfo;
+(MessageReplyList*)MessageListWithNSDictionary:(NSDictionary*)_dic;

@end
