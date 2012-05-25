//
//  GlobalInfo.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "GlobalInfo.h"

@implementation GlobalInfo
@synthesize userId=_userId,userName=_userName;
@synthesize styleType = _styleType;
@synthesize  isResetStyleType = _isResetStyleType;
static GlobalInfo *sharedGlobalInfo;
+(GlobalInfo*)sharedGlobalInfo
{
    if (!sharedGlobalInfo) {
       sharedGlobalInfo  = [[GlobalInfo alloc] init];
        sharedGlobalInfo.styleType = vKTweetDocumentPreviewStyle;
        sharedGlobalInfo.isResetStyleType = NO;
        return sharedGlobalInfo;
    }
    return sharedGlobalInfo;
}
@end
