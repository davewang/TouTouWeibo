//
//  MapDataList.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-22.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MapDataList.h"
#import "MapData.h"
@implementation MapDataList
@synthesize err,mapList;

+(MapDataList*)MapDataListWithNSDictionary:(NSDictionary *)_dic;
{
	MapDataList *mapdataList = [[MapDataList alloc] init];
	
	mapdataList.err = @"0";
	mapdataList.mapList =[[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"cityList"] )
    { 
        [mapdataList.mapList addObject:[MapData MapDataWithNSDictionary:_tDic]];
    }
//	contactList.pageInfo =   [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ]; 
	return mapdataList;
}
@end
