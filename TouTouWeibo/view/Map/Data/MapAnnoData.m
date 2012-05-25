//
//  MapAnnoData.m
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MapAnnoData.h"

@implementation MapAnnoData
@synthesize title,subtitle,coordinate;
@synthesize latitude;
@synthesize longitude;
@synthesize image;
@synthesize cityId;


-(id)initWithCoodinate:(CLLocationCoordinate2D )aCoordinate
{
	if (self = [super init]) {
		coordinate = aCoordinate;
	}
	return self;
}
@end
