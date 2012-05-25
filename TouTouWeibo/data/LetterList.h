//
//  LetterList.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
#import "Letter.h"
@interface LetterList : NSObject
{

      NSString *err;
	  NSArray  *weiboList;
	 Page *pageInfo;
}
@property(retain,nonatomic) NSString *err;
@property(retain,nonatomic) NSArray  *weiboList;
@property(retain,nonatomic) Page *pageInfo;

+(LetterList*)LetterListWithNSDictionary:(NSDictionary*)_dic;
@end
