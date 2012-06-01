//
//  ClassInfo.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-6-1.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ClassInfo.h"

@implementation ClassInfo
@synthesize className;

+(ClassInfo*)  ClassInfoWithNSDictionary:(NSDictionary*)_dic{

 
    ClassInfo *info = [[ClassInfo alloc] init];
    info.className = [_dic objectForKey:@"class"];
    info.classId = [_dic objectForKey:@"classId"];
    info.userId = [_dic objectForKey:@"userId"];
    
    return info;
}
@end
