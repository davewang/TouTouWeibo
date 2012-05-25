//
//  WeiBoModel.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharePhoto.h"
#import "ShareUrl.h"
@interface WeiBoModel : NSObject
{
    NSString* err;
	NSString* uid;
	NSString* actionDescription;
	NSString* headPhoto;
	NSString* userId;
	NSString* userName;
	NSString* mId;
	NSString* mContent;
	NSString* postTime;
	NSString* postTitle;
	NSString* total;
    ShareUrl *shareUrl;
	SharePhoto *sharePhoto;
    //NSString* _timestamp;
    NSString* _timeString;
    time_t createdAt;
    NSString* statusId;
    
    
    //new add
    NSString* _mFrom;
	NSString* _trans;
	
	
	BOOL _isForm;
	
	NSString* _fromId;
	NSString* _fromName;
	NSString* _fromDes;
	NSString* _fromTime;
	NSString* _fromRealPath;
	NSString* _fromSmallPath;
	NSString* _fromUserName;
	NSString* _fromUserId;
	NSString* _fromTrans;
	NSString* _fromTotal;
    
    
    
    
    
    
}
 @property (nonatomic, readonly) NSString*         timestamp;
@property (nonatomic, readonly) NSString*         timeString; 
@property (nonatomic, assign) time_t          createdAt;
@property(retain,nonatomic) NSString* err;
@property(retain,nonatomic) NSString* statusId;
@property(retain,nonatomic) NSString* uid;
@property(retain,nonatomic) NSString* actionDescription;
@property(retain,nonatomic) NSString* headPhoto;
@property(retain,nonatomic) NSString* userId;
@property(retain,nonatomic) NSString* userName;
@property(retain,nonatomic) NSString* mId;
@property(retain,nonatomic) NSString* mContent;
@property(retain,nonatomic) NSString* postTime;
@property(retain,nonatomic) NSString* postTitle;
@property(retain,nonatomic) NSString* total;
@property(retain,nonatomic) ShareUrl* shareUrl;

@property(retain,nonatomic) SharePhoto *sharePhoto;



@property(retain,nonatomic) NSString* _mFrom;
@property(retain,nonatomic) NSString* _trans;


@property BOOL _isForm;

@property(retain,nonatomic) NSString* _fromId;
@property(retain,nonatomic) NSString* _fromName;
@property(retain,nonatomic) NSString* _fromDes;
@property(retain,nonatomic) NSString* _fromTime;
@property(retain,nonatomic) NSString* _fromRealPath;
@property(retain,nonatomic) NSString* _fromSmallPath;
@property(retain,nonatomic) NSString* _fromUserName;
@property(retain,nonatomic) NSString* _fromUserId;
@property(retain,nonatomic) NSString* _fromTrans;
@property(retain,nonatomic) NSString* _fromTotal;
+(WeiBoModel*)WeiBoModelWithNSDictionary:(NSDictionary*)_dic;
@end
