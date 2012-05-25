//
//  Attention.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Attention.h"

@implementation Attention

@synthesize headPhoto,attOfUserId,attOfUserName,context,relation;
+(Attention*)AttentionWithNSDictionary:(NSDictionary *)_dic
{
	Attention * attention = [[Attention alloc] init];
	 
	attention.headPhoto = [_dic objectForKey:@"headPhoto"];//[NSString stringWithFormat:@"%@%@",@"http://119.57.54.48",[_dic objectForKey:@"headPhoto"]];//[_dic objectForKey:@"headPhoto"];
	attention.attOfUserId = [_dic objectForKey:@"attOfUserId"];
	attention.attOfUserName = [_dic objectForKey:@"attOfUserName"];
    attention.context =[_dic objectForKey:@"context"];
      attention.relation =[_dic objectForKey:@"relation"];
	
	return attention;
}
+(Attention*)AttentionWithFanBean:(FanBean *)_fan{
    Attention * attention = [[Attention alloc] init];
    attention.headPhoto = _fan.headPhoto;
    attention.attOfUserId = _fan.fanOfUserId;
    attention.attOfUserName = _fan.fanOfUserName;
    return attention;
}
+(Attention*)AttentionWithFriend :(Friend *)_fried{
    Attention * attention = [[Attention alloc] init];
    attention.headPhoto = _fried.headphoto;
    attention.attOfUserId = _fried.friendId;
    attention.attOfUserName = _fried.friendName;
    
    return attention;
}
@end
