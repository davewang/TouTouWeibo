//
//  ContactBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonFriendBean.h"
@interface ContactBean : NSObject
{
    NSString *uid;
	NSString *image;
	NSString *sex;
	NSString *name;
	NSString *banji;
	NSString *telphone;
	
}
@property(nonatomic,retain)    NSString *uid;
@property(nonatomic,retain)  NSString *image;
@property(nonatomic,retain)  NSString *sex;
@property(nonatomic,retain)  NSString *name;
@property(nonatomic,retain)  NSString *banji;
@property(nonatomic,retain)  NSString *telphone;

+(ContactBean*)ContactBeanWithNSDictionary:(NSDictionary *)_dic;

+(ContactBean*)ContactBeanWithCommonFriendBean:(CommonFriendBean *)_dic;
@end
