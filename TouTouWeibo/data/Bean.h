//
//  Bean.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bean : NSObject {
	NSString *err;
	NSString *msg;
}

@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSString* msg;
+(Bean*)BeanWithNSDictionary:(NSDictionary*)_dic;

@end
