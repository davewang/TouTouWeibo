//
//  GlobalInfo.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    vKTweetDocumentPreviewStyle=0,//浏览图模式
    vKTweetDocumentClassicStyle=1,//经典模式
    vKTweetDocumentWordStyle=2//文字模式
}TweetStyleType;

@interface GlobalInfo : NSObject
{
    
    NSString *_userId;
    NSString *_userName;
    int _styleType;
    BOOL _isResetStyleType;
    
}
@property(nonatomic,retain)NSString *userId;
@property(nonatomic,retain)NSString *userName;

@property(nonatomic,assign)BOOL isResetStyleType;
@property(nonatomic,assign)int styleType;
+(GlobalInfo*)sharedGlobalInfo;
@end
