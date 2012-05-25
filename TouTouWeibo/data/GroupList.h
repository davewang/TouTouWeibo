//
//  GroupList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"

@interface GroupList : NSObject {
	
	NSString *err;
	NSMutableArray *groupInfo;
     Page *pageInfo;
	

}

@property(retain,nonatomic)   Page *pageInfo;
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSMutableArray *groupInfo;
+(GroupList*)GroupListWithNSDictionary:(NSDictionary*)_dic;

@end
