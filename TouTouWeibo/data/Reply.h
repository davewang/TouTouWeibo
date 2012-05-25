//
//  Reply.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageReply.h"
#import "NSDictionaryAdditions.h"
#import "CommonUtils.h"
#import "Attention.h"
#import "FanBean.h"
@interface Reply : NSObject {
	NSString *replyPhoto;
	NSString *replyContext;
	NSString *postsId;
	NSString *replyTime;
	NSString *replyOfUserName;
    NSString* _timeString;
    time_t createdAt;
}
@property (nonatomic, readonly) NSString*         timestamp;
@property (nonatomic, readonly) NSString*         timeString; 
@property (nonatomic, assign) time_t          createdAt;
@property(retain,nonatomic) NSString* replyPhoto;
@property(retain,nonatomic) NSString* replyContext;
@property(retain,nonatomic) NSString* postsId;
@property(retain,nonatomic) NSString* replyTime;
@property(retain,nonatomic) NSString* replyOfUserName;
+(Reply*)ReplyWithNSDictionary:(NSDictionary*)_dic;

+(Reply*)ReplyWithMessageReply:(MessageReply*)mr;

+(Reply*)ReplyWithWeiboModel:(WeiBoModel*)wbm;


+(Reply*)ReplyWithFanBean:(FanBean*)mr;
+(Reply*)ReplyWithAttention:(Attention*)mr;

@end
