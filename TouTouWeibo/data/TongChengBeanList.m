//
//  TongChengBeanList.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "TongChengBeanList.h"
#import "TongChengBean.h"
@implementation TongChengBeanList

@synthesize tongChengList;
@synthesize err;
@synthesize pageInfo;
+(TongChengBeanList*)TongChengBeanListWithNSDictionary:(NSDictionary*)_dic{
    
    TongChengBeanList *commonFriend =[[TongChengBeanList alloc] init];
    
    commonFriend.err = [_dic objectForKey:@"err"];
    commonFriend.tongChengList = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [_dic objectForKey:@"userList"] )
    { 
        [commonFriend.tongChengList  addObject:[TongChengBean TongChengBeanWithNSDictionary:_tDic]];
    }
    commonFriend.pageInfo = [Page PageWithNSDictionary:  [_dic  objectForKey:@"pageInfo"]];
    
    
    return nil;
}
@end