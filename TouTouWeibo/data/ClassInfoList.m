//
//  ClassInfoList.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-6-1.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ClassInfoList.h"
#import "ClassInfo.h"
@implementation ClassInfoList
@synthesize pageInfo,err,classList;


+(ClassInfoList*)ClassInfoListWithNSDictionary:(NSDictionary*)_dic{
      
    
    ClassInfoList *list = [[ClassInfoList alloc] init];
    if (![_dic  objectForKey:@"err"]) {
        list.err = @"SUCCESS";
    }else{
        list.err = [_dic  objectForKey:@"err"];
    }
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    for (NSDictionary *tmp in [_dic  objectForKey:@"userList"] ) {
        
        [arr addObject: [ClassInfo  ClassInfoWithNSDictionary:tmp]];
    }
    list.classList = arr;
    [arr release];
    list.pageInfo = [Page PageWithNSDictionary:  [_dic  objectForKey:@"pageInfo"]];
    
    return list;
}
@end
