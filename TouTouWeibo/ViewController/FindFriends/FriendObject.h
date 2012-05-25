//
//  FriendObject.h
//  TouTouWeibo
//
//  Created by BobbyLi on 5/9/12.
//  Copyright (c) 2012 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendObject : NSObject
{
    NSString *userName;
    NSString *userSex;
    NSString *userCity;
    NSString *className;
    NSString *workName;
    NSString *qqNo;
    NSString *msnNo;
    NSString *phone;
    NSString *introduction;
    NSString *companyName; 
    NSString *companyAddress;
    NSString *companyTel;
    NSString *userPhoto;
    
    NSString *remark;
    NSString *personalBaseInformation;
    
    NSString *contactConfig ;
    NSString *workConfig;
    NSString *F_friendId;
    NSString *isFriend;
    
}

+(FriendObject*)FriendObjectWithNSDictionary:(NSDictionary*)_dic;
@property (nonatomic,retain)NSString *userName;
@property (nonatomic,retain)NSString *className;
@property (nonatomic,retain)NSString *workName;
@property (nonatomic,retain)NSString *qqNo;
@property (nonatomic,retain)NSString *msnNo;
@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)NSString *introduction;
@property (nonatomic,retain)NSString *companyName;
@property (nonatomic,retain)NSString *companyAddress;
@property (nonatomic,retain)NSString *companyTel;
@property (nonatomic,retain)NSString *userSex;
@property (nonatomic,retain)NSString *userCity;

@property (nonatomic,retain)NSString *userPhoto;

@property (nonatomic,retain)NSString *remark;


@property (nonatomic,retain)NSString *personalBaseInformation;


@property (nonatomic,retain)NSString *contactConfig ;

@property (nonatomic,retain)NSString *workConfig;

@property (nonatomic,retain)NSString *F_friendId;

@property (nonatomic,retain)NSString *isFriend;
@end
