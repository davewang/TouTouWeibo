//
//  Page.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject
{
    int pageNo;
    int sumPage;
    int totals;
}
@property int pageNo;
@property int sumPage;
@property int totals;

+(Page*)PageWithNSDictionary:(NSDictionary*)_dic;
@end
