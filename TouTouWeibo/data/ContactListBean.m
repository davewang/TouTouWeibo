//
//  ContactListBean.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ContactListBean.h"
#import "Page.h"
#import "ContactBean.h"
@implementation ContactListBean
@synthesize err,contactList,pageInfo;
+(ContactListBean*)ContactListBeanWithNSDictionary:(NSDictionary *)_dic
{
	ContactListBean *contactList = [[ContactListBean alloc] init];
	
	contactList.err = @"0";
	contactList.contactList =[[NSMutableArray alloc] initWithCapacity:2];
	for(NSDictionary *_tDic in [_dic objectForKey:@"userList"] )
    { 
        [contactList.contactList addObject:[ContactBean ContactBeanWithNSDictionary:_tDic]];
    }
	contactList.pageInfo =   [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ]; 
	return contactList;
}
@end
