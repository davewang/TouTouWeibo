//
//  CommonFriendListBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFriendListBean : NSObject
{
NSString *err;
NSMutableArray *commonFriendList;
Page *pageInfo;
}
@property(retain,nonatomic)NSString *err;
@property(retain,nonatomic)NSMutableArray *commonFriendList;
@property(retain,nonatomic)Page *pageInfo;
+(CommonFriendListBean*)CommonFriendListBeanWithNSDictionary:(NSDictionary*)_dic;

@end
