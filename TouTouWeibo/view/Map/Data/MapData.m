//
//  MapData.m
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MapData.h"

@implementation MapData
@synthesize lat;
@synthesize lon;
@synthesize counts;//返回的图片
@synthesize pId;
@synthesize pName; 
@synthesize cId;//未知
@synthesize cName;
 

+(MapData*)MapDataWithNSDictionary:(NSDictionary*)_dic
{
     MapData *map = [[MapData alloc] init];
     map.pId = [_dic objectForKey:@"pId"];
     map.pName = [_dic objectForKey:@"pName"];
     map.cId = [_dic objectForKey:@"cId"];
     map.cName = [_dic objectForKey:@"cName"];
     map.counts = [_dic objectForKey:@"counts"];
     map.lat = [_dic objectForKey:@"latitude"];
     map.lon = [_dic objectForKey:@"longitude"];
     return map;
}

@end
