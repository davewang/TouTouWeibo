//
//  ContactBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ContactBean.h"

@implementation ContactBean
@synthesize uid,image,sex,name,banji,telphone;
+(ContactBean*)ContactBeanWithNSDictionary:(NSDictionary *)_dic
{
    ContactBean *letter = [[ContactBean alloc] init];
    
     
    letter.uid = [_dic objectForKey:@"userId" ]; //jsonObject.getString("headPhoto");
    letter.sex = [_dic objectForKey:@"sex" ];//jsonObject.getString("postTime");
    letter.name = [_dic objectForKey:@"userName" ];//jsonObject.getString("postTitle");
    letter.image = [_dic objectForKey:@"headPhoto" ]; //jsonObject.getString("headPhoto");
    letter.telphone = [_dic objectForKey:@"telphone" ];//jsonObject.getString("postTime");
    letter.banji = [_dic objectForKey:@"class" ];//jsonObject.getString("postTitle");
    
    
    return letter;
}
+(ContactBean*)ContactBeanWithCommonFriendBean:(CommonFriendBean *)_dic
{
    
    
    ContactBean *letter = [[ContactBean alloc] init];
    
    
    letter.uid = _dic.userId;//[_dic objectForKey:@"userId" ]; //jsonObject.getString("headPhoto");
    letter.sex = _dic.sex;//[_dic objectForKey:@"sex" ];//jsonObject.getString("postTime");
    letter.name = _dic.userName;//[_dic objectForKey:@"userName" ];//jsonObject.getString("postTitle");
    letter.image = _dic.userPhoto;//[_dic objectForKey:@"headPhoto" ]; //jsonObject.getString("headPhoto");
    letter.telphone = _dic.telphone;//[_dic objectForKey:@"telphone" ];//jsonObject.getString("postTime");
    letter.banji = _dic.banji;//[_dic objectForKey:@"class" ];//jsonObject.getString("postTitle");
    return letter;
    
}

@end
