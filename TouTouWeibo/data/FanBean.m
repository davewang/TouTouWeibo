//
//  FanBean.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FanBean.h"


@implementation FanBean
@synthesize headPhoto,fanOfUserId,fanOfUserName,context,relation;
+(FanBean*)FanBeanWithNSDictionary:(NSDictionary*)_dic{
    FanBean *fan = [[FanBean alloc] init];
     
	fan.headPhoto = [_dic objectForKey:@"headPhoto"];//[NSString stringWithFormat:@"%@%@",@"http://119.57.54.48",[_dic objectForKey:@"headPhoto"]];
	fan.fanOfUserId = [_dic objectForKey:@"fanOfUserId"];
	fan.fanOfUserName = [_dic objectForKey:@"fanOfUserName"];
    fan.context =[_dic objectForKey:@"context"];
    fan.relation =[_dic objectForKey:@"relation"];
    
    return fan;
}


@end
