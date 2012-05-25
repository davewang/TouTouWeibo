//
//  CommonFriendBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFriendBean : NSObject
{
	NSString *banji;
	NSString *userName;
	NSString *userPhoto;
	NSString *userId;
	NSString *sex;
	NSString *telphone;
    
}
@property(nonatomic,retain)	NSString *banji;
@property(nonatomic,retain)	NSString *userName;
@property(nonatomic,retain)	NSString *userPhoto;
@property(nonatomic,retain)	NSString *userId;
@property(nonatomic,retain)	NSString *sex;
@property(nonatomic,retain)	NSString *telphone;
+(CommonFriendBean*) CommonFriendBeanWithNSDictionary:(NSDictionary*)_dic;
@end
