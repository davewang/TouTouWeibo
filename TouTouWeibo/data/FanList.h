//
//  FanList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"

@interface FanList : NSObject {
	NSString *err;
	NSMutableArray *fanList;
	Page *pageInfo;

}
@property(retain,nonatomic)NSString *err;
@property(retain,nonatomic)NSMutableArray *fanList;
@property(retain,nonatomic)Page *pageInfo;
+(FanList*)FanListModelWithNSDictionary:(NSDictionary*)_dic;


@end
