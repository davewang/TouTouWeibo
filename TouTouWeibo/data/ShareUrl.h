//
//  ShareUrl.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareUrl : NSObject
{
  NSString* shareUrlDesc;
  NSString* shareUrlName;
  NSString* shareUrlId;
}
@property(nonatomic,retain) NSString* shareUrlDesc;
@property(nonatomic,retain) NSString* shareUrlName;
@property(nonatomic,retain) NSString* shareUrlId; 

+(ShareUrl*)ShareUrlWithNSDictionary:(NSDictionary*)_dic;
@end
