//
//  MapAnnoData.h
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnoData : NSObject

@property(nonatomic,retain)NSString * title;

@property(nonatomic,retain)NSString * cityId;
@property(nonatomic,retain)NSString * subtitle;
@property(nonatomic,retain)NSString * image;
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic)CGFloat longitude;
@property(nonatomic)CGFloat latitude;

-(id)initWithCoodinate:(CLLocationCoordinate2D)aCoordinate;
@end
