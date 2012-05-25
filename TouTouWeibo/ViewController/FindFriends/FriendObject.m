//
//  FriendObject.m
//  TouTouWeibo
//
//  Created by BobbyLi on 5/9/12.
//  Copyright (c) 2012 DaveDev. All rights reserved.
//

#import "FriendObject.h"

@implementation FriendObject
@synthesize className;
@synthesize qqNo;
@synthesize msnNo;
@synthesize phone;
@synthesize workName;
@synthesize companyTel;
@synthesize companyName;
@synthesize introduction;
@synthesize companyAddress;
@synthesize userName; 
@synthesize userSex;
@synthesize userCity;
@synthesize userPhoto;
@synthesize remark;
@synthesize personalBaseInformation;
@synthesize contactConfig;
@synthesize workConfig;
@synthesize F_friendId;
@synthesize isFriend;
/*
 {"userName":"wanghc","userPhoto":"url",“sex”:”1”,"intro":"我是一个","qq":"1" ,”class”:”班级”,” msn”:”11”, "post":"职务", ”telphone”：”12345”,” remark”:”备注”,”companyName”:”公司名称”，”companyAddr”：”公司地址”，”companyCall”:”123”,” userId”:”11” ,"area":"地区","personalBaseInformation":1," contactConfig":1, "workConfig":1, "F_friendId":1,"isFriend":"true"}]
 
 */
+(FriendObject*)FriendObjectWithNSDictionary:(NSDictionary*)_dic{
    FriendObject *f = [[FriendObject alloc] init];
    f.userName =[_dic objectForKey:@"userName"];
    f.userPhoto =[_dic objectForKey:@"userPhoto"];
    f.userSex =[_dic objectForKey:@"sex"];
    f.introduction =[_dic objectForKey:@"intro"];
    f.qqNo =[_dic objectForKey:@"qq"];
    f.className =[_dic objectForKey:@"class"];
    f.msnNo =[_dic objectForKey:@"msn"];
    f.workName =[_dic objectForKey:@"post"];
    f.phone =[_dic objectForKey:@"telphone"];
    f.remark =[_dic objectForKey:@"remark"];
    
    f.companyName =[_dic objectForKey:@"companyName"];
    
    f.companyAddress =[_dic objectForKey:@"companyAddr"];
    f.companyTel =[_dic objectForKey:@"companyCall"];
    
    f.contactConfig =[_dic objectForKey:@"contactConfig"];
    
    f.isFriend =[_dic objectForKey:@"isFriend"];
    
    f.workConfig =[_dic objectForKey:@"workConfig"];
    
    f.F_friendId =[_dic objectForKey:@"F_friendId"];
    return f;
    
} 
-(NSString *)description
{
    NSMutableString *sb = [[[NSMutableString alloc] init] autorelease];
    
    [sb appendFormat:@"\n{userName:%@\n",userName];
    [sb appendFormat:@"userPhoto:%@\n",userPhoto];
    [sb appendFormat:@"F_friendId:%@\n",F_friendId];
    [sb appendFormat:@"workConfig:%@\n",workConfig];
    [sb appendFormat:@"isFriend:%@\n",isFriend];
    [sb appendFormat:@"contactConfig:%@\n",contactConfig];
    
    [sb appendFormat:@"companyTel:%@\n",companyTel];
    [sb appendFormat:@"remark:%@\n",remark];
    [sb appendFormat:@"phone:%@\n",phone];
    [sb appendFormat:@"workName:%@\n",workName];
    [sb appendFormat:@"qqNo:%@\n",qqNo];
    [sb appendFormat:@"msnNo:%@\n",msnNo];
    [sb appendFormat:@"userSex:%@\n",userSex];
    
    [sb appendFormat:@"class:%@\n",className];
    [sb appendFormat:@"introduction:%@\n", introduction];
    [sb appendFormat:@"userSex:%@\n",userSex];
   
 return sb  ;
}

-(void)dealloc
{
    [userName release];
    [userCity release];
    [className release];
    [qqNo release];
    [msnNo release];
    [workName release];
    [companyAddress release];
    [introduction release];
    [companyName release];
    [companyTel release];
    [userSex release];
    [super dealloc];
    
}
@end
