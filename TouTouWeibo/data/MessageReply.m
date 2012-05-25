//
//  Message.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageReply.h"
#import "CommonUtils.h"

@implementation MessageReply
@synthesize userId,userName,postTime,mContent;
@synthesize headPhoto,mId;
+(MessageReply*)MessageWithNSDictionary:(NSDictionary *)_dic
{
	MessageReply *m = [[MessageReply alloc] init];
    m.mId = [_dic objectForKey:@"mId"];
	m.userId = [_dic objectForKey:@"userId"];
	m.userName = [_dic objectForKey:@"userName"];
	m.postTime = [_dic objectForKey:@"postTime"];
	m.mContent = [_dic objectForKey:@"mContent"];
    m.headPhoto = [CommonUtils getRealHeadPhotoUrl:[_dic objectForKey:@"headPhoto"]];
	return m;

}

@end
