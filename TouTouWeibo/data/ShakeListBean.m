//
//  ShakeListBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ShakeListBean.h"
#import "ShakeBean.h"
@implementation ShakeListBean
@synthesize  err,shakeList,pageInfo;

+(ShakeListBean*)ShakeListBeanWithNSDictionary:(NSDictionary*)_dic{

 
    ShakeListBean *shakeListBean =[[ShakeListBean alloc] init];
    
    shakeListBean.err = [_dic objectForKey:@"err"];
    shakeListBean.shakeList = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [_dic objectForKey:@"userList"] )
    { 
        [shakeListBean.shakeList addObject:[ShakeBean ShakeBeanWithNSDictionary:_tDic]];
    }
   
    shakeListBean.pageInfo =   [Page PageWithNSDictionary:  [_dic  objectForKey:@"pageInfo"]];
    
    
    return nil;
}
@end
