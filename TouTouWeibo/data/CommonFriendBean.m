//
//  CommonFriendBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CommonFriendBean.h"

@implementation CommonFriendBean
@synthesize banji,userId,userName,userPhoto,sex,telphone;
//+(CommonFriendBean*) CommonFriendBeanWithNSDictionary:(NSDictionary*)_dic{
//    
//    
//
//    CommonFriendBean *bean = [[CommonFriendBean alloc] init];
//    bean.userId = [_dic objectForKey:@"userId"];
//    bean.userName = [_dic objectForKey:@"userName"];
//    bean.userPhoto = [_dic objectForKey:@"userPhoto"];
//    bean.sex = [_dic objectForKey:@"sex"];
//    bean.telphone = [_dic objectForKey:@"telphone"];
//    bean.banji =[_dic objectForKey:@"class"];
//    return bean;
//}
+(CommonFriendBean*) CommonFriendBeanWithNSDictionary:(NSDictionary*)_dic{
    
    
    
    CommonFriendBean *bean = [[CommonFriendBean alloc] init];
    bean.userId = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"userId"]];
    bean.userName = [_dic objectForKey:@"userName"];
    bean.userPhoto = [_dic objectForKey:@"userPhoto"];
    bean.sex = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"sex"]];
    bean.telphone =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"telphone"]];
    bean.banji =[_dic objectForKey:@"class"];
    return bean;
}
@end
