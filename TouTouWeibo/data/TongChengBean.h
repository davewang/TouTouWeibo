//
//  TongChengBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TongChengBean : NSObject
{
    NSString *banji;
	NSString *userName;
	NSString *userPhoto;
	NSString *userId;
	NSString *sex;
	NSString *telphone;
    BOOL isFriend;
    
}
@property(nonatomic,retain)	NSString *banji;
@property(nonatomic,retain)	NSString *userName;
@property(nonatomic,retain)	NSString *userPhoto;
@property(nonatomic,retain)	NSString *userId;
@property(nonatomic,retain)	NSString *sex;
@property(nonatomic,retain)	NSString *telphone;

@property(nonatomic)	BOOL isFriend;
+(TongChengBean *)TongChengBeanWithNSDictionary:(NSDictionary*)_dic;
@end
