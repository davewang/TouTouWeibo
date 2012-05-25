//
//  Message.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MessageReply : NSObject {
	NSString *userId;
	NSString *userName;
	NSString *postTime;
	NSString *mContent;
    NSString *headPhoto;
    NSString *mId;
}
@property(retain,nonatomic) NSString* userId;
@property(retain,nonatomic) NSString* userName;
@property(retain,nonatomic) NSString* postTime;
@property(retain,nonatomic) NSString* mContent;
@property(retain,nonatomic) NSString* headPhoto;

@property(retain,nonatomic) NSString* mId;
+(MessageReply*)MessageWithNSDictionary:(NSDictionary*)_dic;

@end
