//
//  ClassInfoList.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-6-1.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
@interface ClassInfoList : NSObject
{
    NSString *err;
    NSArray  *classList;
    Page *pageInfo;
}

@property(retain,nonatomic) NSString *err;
@property(retain,nonatomic) NSArray  *classList;
@property(retain,nonatomic) Page *pageInfo;
+(ClassInfoList*)ClassInfoListWithNSDictionary:(NSDictionary*)_dic;
@end
