//
//  Bean.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Bean.h"


@implementation Bean
@synthesize err,msg;
+(Bean*)BeanWithNSDictionary:(NSDictionary *)_dic
{
	Bean *bean = [[Bean alloc] init];
	bean.err = [_dic objectForKey:@"err"];
	bean.msg = [_dic objectForKey:@"msg"];
	return bean;
}

@end
