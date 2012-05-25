//
//  ShakeBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//



@interface ShakeBean : NSObject
{
    
	NSString *err;
	NSString *userName;
	NSString *userPhoto;
	NSString *userId;
	NSString *sex;
	NSString *range;
    
	NSString *intro;
	NSString *area;
	NSString *post;
	NSString *banji;
	
	NSString *shakeTime;
    
	NSString *personalBaseInformation;
	
	BOOL isFriend;
}
@property(nonatomic,retain)	NSString *err;
@property(nonatomic,retain)	NSString *userName;
@property(nonatomic,retain)	NSString *userPhoto;
@property(nonatomic,retain)	NSString *userId;
@property(nonatomic,retain)	NSString *sex;
@property(nonatomic,retain)	NSString *range;

@property(nonatomic,retain)	NSString *intro; 
@property(nonatomic,retain)	NSString *area;
@property(nonatomic,retain)	NSString *post;
@property(nonatomic,retain)	NSString *banji;

@property(nonatomic,retain)	NSString *shakeTime;

@property(nonatomic,retain)	NSString *personalBaseInformation;

@property(nonatomic)	BOOL isFriend;
+(ShakeBean*)ShakeBeanWithNSDictionary:(NSDictionary*)_dic;
@end
