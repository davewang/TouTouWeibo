//
//  TongChengBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "TongChengBean.h"

@implementation TongChengBean

@synthesize banji,userId,userName,userPhoto,sex,telphone,isFriend;


+(TongChengBean *)TongChengBeanWithNSDictionary:(NSDictionary*)_dic{
    TongChengBean *bean = [[TongChengBean alloc] init];
    bean.userId = [_dic objectForKey:@"userId"];
    bean.userName = [_dic objectForKey:@"userName"];
    bean.userPhoto = [_dic objectForKey:@"userPhoto"];
    bean.sex = [_dic objectForKey:@"sex"];
    bean.telphone = [_dic objectForKey:@"telphone"];
    bean.banji =[_dic objectForKey:@"class"];
    NSString *friendFlag = [_dic objectForKey:@"isFriend"];
    if([friendFlag isEqualToString:@"true"]){
        bean.isFriend = true;
    }else{
        bean.isFriend = false;
    }
    return bean;
}

@end
