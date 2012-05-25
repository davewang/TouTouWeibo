//
//  ShakeBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ShakeBean.h"

@implementation ShakeBean
@synthesize err,userName,userPhoto,userId,range,sex,shakeTime,post,area,intro,isFriend;
+(ShakeBean*)ShakeBeanWithNSDictionary:(NSDictionary*)_dic{

    ShakeBean *shakeBean =[[ShakeBean alloc ] init];
    
    shakeBean.err =[_dic objectForKey:@"err"];
    
    shakeBean.userId = [_dic objectForKey:@"userId"];
    shakeBean.userName = [_dic objectForKey:@"userName"];
    shakeBean.userPhoto = [_dic objectForKey:@"userPhoto"];
    shakeBean.sex = [_dic objectForKey:@"sex"];
    shakeBean.range = [_dic objectForKey:@"range"];
    shakeBean.banji = [_dic objectForKey:@"class"];
    shakeBean.area = [_dic objectForKey:@"area"];
    shakeBean.intro = [_dic objectForKey:@"intro"];
    shakeBean.post = [_dic objectForKey:@"post"];
    shakeBean.personalBaseInformation = [_dic objectForKey:@"personalBaseInformation"];
    
    NSString *friendFlag = [_dic objectForKey:@"isFriend"];
    if([friendFlag isEqualToString:@"true"]){
        shakeBean.isFriend = true;
    }else{
        shakeBean.isFriend = false;
    }
    return nil;
}
@end
