//
//  FriendList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"

@interface FriendList : NSObject {
	NSString *err;
	NSMutableArray *friendInfo;
     Page *pageInfo;
}
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSMutableArray *friendInfo;

@property(retain,nonatomic)   Page *pageInfo;
+(FriendList*)FriendListWithNSDictionary:(NSDictionary*)_dic;

@end
