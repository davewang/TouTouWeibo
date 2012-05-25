//
//  ShakeListBean.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShakeListBean : NSObject
{
    
	NSString *err;
    NSMutableArray *shakeList;
    Page *pageInfo;
}
@property(retain,nonatomic)NSString *err;

@property(retain,nonatomic)NSMutableArray *shakeList;

@property(retain,nonatomic)Page *pageInfo;
+(ShakeListBean*)ShakeListBeanWithNSDictionary:(NSDictionary*)_dic;
@end
