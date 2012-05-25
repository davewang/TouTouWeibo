//
//  Friend.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Friend : NSObject {
	NSString *friendName;
	NSString *friendId;
    NSString *headphoto;
	Boolean checked;
}
@property(retain,nonatomic) NSString* friendName;
@property(retain,nonatomic) NSString* friendId;

@property(retain,nonatomic) NSString* headphoto;
@property Boolean checked;
+(Friend*)FriendWithNSDictionary:(NSDictionary*)_dic;

@end
