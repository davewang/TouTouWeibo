//
//  TongChengBeanList.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-23.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TongChengBeanList : NSObject
{

    
	NSString *err;
	NSMutableArray *tongChengList;
	Page *pageInfo;
    

}
@property(nonatomic,retain)	NSString *err;
@property(nonatomic,retain)NSMutableArray *tongChengList;
@property(nonatomic,retain)Page *pageInfo;
@end
