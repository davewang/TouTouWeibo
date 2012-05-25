//
//  Letter.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Letter : NSObject
{
	BOOL isSending;	//是否在发送数据
	
	NSString *userId;
	NSString *headPhoto;
    NSString *postTitle;
	NSString *postTime;
	BOOL isSelf;
	
}
+(Letter*)LetterWithNSDictionary:(NSDictionary*)_dic;
@property(nonatomic)BOOL isSending;	//是否在发送数据

@property(retain,nonatomic)NSString *userId;
@property(retain,nonatomic)NSString *headPhoto;
@property(retain,nonatomic)NSString *postTitle;
@property(retain,nonatomic)NSString *postTime;

@property(nonatomic)BOOL isSelf;
@end
