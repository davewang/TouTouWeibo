//
//  SharePhoto.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharePhoto : NSObject
{
    NSString* sharePhotoName;
	NSString* sharePhotoTime;
	NSString* sharePhotoId;
	NSString* sharePhotoDes;
	NSString* sharePhotoSmallPath;
	NSString* sharePhotoRealPath;
}
@property(nonatomic,retain)  NSString* sharePhotoName;
@property(nonatomic,retain)  NSString* sharePhotoTime;
@property(nonatomic,retain)  NSString* sharePhotoId;
@property(nonatomic,retain)  NSString* sharePhotoDes;
@property(nonatomic,retain)  NSString* sharePhotoSmallPath;
@property(nonatomic,retain)  NSString* sharePhotoRealPath;
+(SharePhoto*)SharePhotoWithNSDictionary:(NSDictionary*)_dic;
@end
