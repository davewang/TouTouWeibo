//
//  FanBean.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FanBean : NSObject {
	NSString* headPhoto;
	NSString* fanOfUserId;
	NSString* fanOfUserName;
    NSString* context;
    NSString * relation;
}

@property(retain,nonatomic) NSString* headPhoto;
@property(retain,nonatomic) NSString* fanOfUserId;
@property(retain,nonatomic) NSString* fanOfUserName;

@property(retain,nonatomic) NSString* relation;
@property(retain,nonatomic) NSString* context;
+(FanBean*)FanBeanWithNSDictionary:(NSDictionary*)_dic;

@end
