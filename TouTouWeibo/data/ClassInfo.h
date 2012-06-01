//
//  ClassInfo.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-6-1.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassInfo : NSObject
{
   // {"pageInfo":{"pageNo":1,"sumPage":1,"totals":1},"userList":[{"classId":100188,"userId":5078,"class":"PE37班"}]}
    NSString *classId;
    NSString *className;
    NSString *userId;
}
+(ClassInfo*)  ClassInfoWithNSDictionary:(NSDictionary*)_dic;
@property(nonatomic,retain)NSString *className;
@property(nonatomic,retain)NSString *classId;
@property(nonatomic,retain)NSString *userId;
@end
