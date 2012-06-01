//
//  Account.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-4.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo
@synthesize  err,uId,attentionCount,birthplaceofprovince,descirption,fanCount,headphoto,name,nickname,oftenAddress,oftenAddressId,oftenAddressOfProvince,oftenAddressOfProvinceId,phone,sex,relation;
@synthesize weiboCount;
@synthesize gender;
-(int)gender{
    
    if (self.sex) {
        if ([self.sex isEqualToString:@"1"] ) {
            return GenderMale;
        }else if ([self.sex isEqualToString:@"2"] ) {
            return GenderFemale;
        }
        
    }else{
        
        return GenderUnknow;
    }
    return GenderUnknow;
}

+(AccountInfo*)AccountWithFriendObject:(FriendObject*)_dic{

    AccountInfo *account = [[AccountInfo alloc] init];
    account.name = _dic.userName;
    account.headphoto = _dic.userPhoto;
    account.sex = [_dic.userSex description];
    //account
    return account;

}
+(AccountInfo*)AccountWithNSDictionary:(NSDictionary*)_dic
{
    NSLog(@"_dic ===>%@",_dic);
    
    AccountInfo *account = [[AccountInfo alloc] init];
    
    account.err = [_dic objectForKey:@"err"];
    if (!account.err) {
        NSDictionary *userInfo = [_dic objectForKey:@"userInfo"];
        account.uId = [userInfo objectForKey:@"id"];
        account.phone = [userInfo objectForKey:@"phone"];
        account.nickname = [userInfo objectForKey:@"nickname"];
        account.oftenAddress = [userInfo objectForKey:@"oftenAddress"];
        account.descirption = [userInfo objectForKey:@"descirption"];
        account.headphoto = [userInfo objectForKey:@"headphoto"]; 
        account.name = [userInfo objectForKey:@"name"];
        account.sex = [userInfo objectForKey:@"sex"];
        account.oftenAddressOfProvince = [userInfo objectForKey:@"oftenAddressOfProvince"];
        account.birthplaceofprovince = [userInfo objectForKey:@"birthplaceofprovince"];
        account.relation = [userInfo objectForKey:@"relation"];
        account.attentionCount = [userInfo objectForKey:@"attentionCount"];
        account.fanCount = [userInfo objectForKey:@"fanCount"];
        account.oftenAddressId = [userInfo objectForKey:@"oftenAddressId"];
        account.oftenAddressOfProvinceId = [userInfo objectForKey:@"oftenAddressOfProvinceId"];
        account.weiboCount = [userInfo objectForKey:@"weiboCount"];
        
    }
    
    
    return account;
}
@end

