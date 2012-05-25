//
//  ContactListBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactListBean : NSObject
{
    NSString *err;
	NSMutableArray *contactList;
	Page *pageInfo;
}
@property(nonatomic,retain)NSString *err;
@property(nonatomic,retain)NSMutableArray *contactList;
@property(nonatomic,retain)Page *pageInfo;

+(ContactListBean*)ContactListBeanWithNSDictionary:(NSDictionary *)_dic;
@end
