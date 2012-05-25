//
//  ShareUrl.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ShareUrl.h"

@implementation ShareUrl
@synthesize shareUrlId,shareUrlDesc,shareUrlName;

+(ShareUrl*)ShareUrlWithNSDictionary:(NSDictionary*)_dic{

    if ([_dic isKindOfClass:[NSArray class]]) {
        _dic =[(NSArray*)_dic objectAtIndex:0];
    }
    ShareUrl *detail = [[ShareUrl alloc] init];
    detail.shareUrlId = [_dic objectForKey:@"shareUrlId"];
    
    detail.shareUrlDesc = [_dic objectForKey:@"shareUrlDesc"];
    
    detail.shareUrlName = [_dic objectForKey:@"shareUrlName"];
    return detail;
}
@end
