//
//  CommonFriendListBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CommonFriendListBean.h"
#import "CommonFriendBean.h"
@implementation CommonFriendListBean
@synthesize commonFriendList;
@synthesize err;
@synthesize pageInfo;
+(CommonFriendListBean*)CommonFriendListBeanWithNSDictionary:(NSDictionary*)_dic{

    CommonFriendListBean *commonFriend =[[CommonFriendListBean alloc] init];
    
    commonFriend.err = [_dic objectForKey:@"err"];
    commonFriend.commonFriendList = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [_dic objectForKey:@"userList"] )
    { 
        [commonFriend.commonFriendList  addObject:[CommonFriendBean CommonFriendBeanWithNSDictionary:_tDic]];
    }
    commonFriend.pageInfo = [Page PageWithNSDictionary:  [_dic  objectForKey:@"pageInfo"]];
    
    
    return nil;
}
@end
