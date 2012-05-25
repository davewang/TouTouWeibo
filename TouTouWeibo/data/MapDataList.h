//
//  MapDataList.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-22.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapDataList : NSObject
{
    NSString *err;
	NSMutableArray *mapList;
//	Page *pageInfo;
}
@property(nonatomic,retain)NSString *err;
@property(nonatomic,retain)NSMutableArray *mapList;
//@property(nonatomic,retain)Page *pageInfo;

+(MapDataList*)MapDataListWithNSDictionary:(NSDictionary *)_dic;
@end
