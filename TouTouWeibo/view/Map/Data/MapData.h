//
//  MapData.h
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface MapData : NSObject

@property(nonatomic,retain)NSString * lat;
@property(nonatomic,retain)NSString * lon;
//@property(nonatomic,retain)NSString * icon;//返回的图片
@property(nonatomic,retain)NSString * pId;
@property(nonatomic,retain)NSString * pName;
@property(nonatomic,retain)NSString * cId;//等级
@property(nonatomic,retain)NSString * counts;//未知
@property(nonatomic,retain)NSString * cName;//未知

+(MapData*)MapDataWithNSDictionary:(NSDictionary*)_dic;
@end
 
 