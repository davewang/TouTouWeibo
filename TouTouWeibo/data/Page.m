//
//  Page.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "Page.h"

@implementation Page
@synthesize pageNo,sumPage;
@synthesize totals;
+(Page*)PageWithNSDictionary:(NSDictionary*)_dic{

    Page *page = [[Page alloc] init];
    
    page.pageNo = [[_dic objectForKey:@"pageNo"] intValue];
    page.sumPage = [[_dic objectForKey:@"sumPage"] intValue];
    page.totals = [[_dic objectForKey:@"totals"] intValue];
    return page;
}
@end
