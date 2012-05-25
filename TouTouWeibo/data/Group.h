//
//  Group.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Group : NSObject {
	NSString *groupId;
	NSString *groupName;
	Boolean isChecked;
}
@property(retain,nonatomic) NSString* groupId;
@property(retain,nonatomic) NSString* groupName;
+(Group*)GroupWithNSDictionary:(NSDictionary*)_dic;

@end
