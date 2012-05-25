//
//  Attention.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FanBean.h"
@interface Attention : NSObject {
	NSString* headPhoto;
	NSString* attOfUserId;
	NSString* attOfUserName;
    NSString* context;
    NSString * relation;
}
@property(retain,nonatomic) NSString* headPhoto;
@property(retain,nonatomic) NSString* attOfUserId;
@property(retain,nonatomic) NSString* attOfUserName;

@property(retain,nonatomic) NSString* relation;
@property(retain,nonatomic) NSString* context;
+(Attention*)AttentionWithNSDictionary:(NSDictionary*)_dic;
+(Attention*)AttentionWithFanBean:(FanBean *)_fan;
+(Attention*)AttentionWithFriend :(Friend *)_fried;
@end
