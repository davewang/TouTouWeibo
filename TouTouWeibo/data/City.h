//
//  City.h
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface City : NSObject {
	NSString *name;
	NSString *cId;
	NSString *pId;

}
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *cId;
@property(retain,nonatomic) NSString *pId;
+(City*)CityWithNSDictionary:(NSDictionary*)_dic;

@end
