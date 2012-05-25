//
//  AttentionList.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"

@interface AttentionList : NSObject {
	NSString* err;
	NSMutableArray *attentionList;
	Page *pageInfo;
	

}
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSMutableArray *attentionList;
@property(retain,nonatomic)Page *pageInfo;
+(AttentionList*)AttentionListWithNSDictionary:(NSDictionary*)_dic;


@end
