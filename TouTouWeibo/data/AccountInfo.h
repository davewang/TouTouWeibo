//
//  Account.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-4.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendObject.h"
typedef enum {
    GenderUnknow = 0,
    GenderMale,
    GenderFemale,
} Gender;

@interface AccountInfo : NSObject
{
    
	NSString* err;
	NSString* uId;
	NSString* phone;
	NSString* nickname;
	NSString* oftenAddress;
	NSString* descirption;
	NSString* headphoto;
	NSString* name;
	NSString* sex;
	NSString* oftenAddressOfProvince;
	NSString* birthplaceofprovince;
	NSString* relation;
	NSString* attentionCount;
	NSString* fanCount;
	NSString* oftenAddressId;
	NSString* oftenAddressOfProvinceId;
    NSString* weiboCount;
    int gender;
}
@property(nonatomic,assign) int gender;
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSString* uId;
@property(retain,nonatomic) NSString* phone;
@property(retain,nonatomic) NSString* nickname;
@property(retain,nonatomic) NSString* oftenAddress;
@property(retain,nonatomic) NSString* descirption;
@property(retain,nonatomic) NSString* headphoto;
@property(retain,nonatomic) NSString* name;
@property(retain,nonatomic) NSString* sex;
@property(retain,nonatomic) NSString* oftenAddressOfProvince;
@property(retain,nonatomic) NSString* birthplaceofprovince;
@property(retain,nonatomic) NSString* relation;
@property(retain,nonatomic) NSString* attentionCount;
@property(retain,nonatomic) NSString* fanCount;
@property(retain,nonatomic) NSString* oftenAddressId;
@property(retain,nonatomic) NSString* oftenAddressOfProvinceId;
@property(retain,nonatomic) NSString* weiboCount;
+(AccountInfo*)AccountWithNSDictionary:(NSDictionary*)_dic;

+(AccountInfo*)AccountWithFriendObject:(FriendObject*)_dic;
@end
