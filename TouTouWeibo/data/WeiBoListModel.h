//
//  WeiBoListModel.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
#import "WeiBoModel.h"
@interface WeiBoListModel : NSObject
{
    NSString *err;
	NSMutableArray *weiboList;
    Page *pageInfo;
	NSString *name;
	NSString *uid;

}
@property(retain,nonatomic)NSString *err;
@property(retain,nonatomic)NSMutableArray *weiboList;
@property(retain,nonatomic)Page *pageInfo;
@property(retain,nonatomic)NSString *name;
@property(retain,nonatomic)NSString *uid;
+(WeiBoListModel*)WeiBoListModelWithNSDictionary:(NSDictionary*)dic;

@end
