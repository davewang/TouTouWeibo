//
//  SharePhoto.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "SharePhoto.h"

@implementation SharePhoto
@synthesize  sharePhotoId,sharePhotoDes,sharePhotoName,sharePhotoTime,sharePhotoRealPath,sharePhotoSmallPath;

+(SharePhoto*)SharePhotoWithNSDictionary:(NSDictionary*)_dic{
    
    if ([_dic isKindOfClass:[NSArray class]]) {
        _dic =[(NSArray*)_dic objectAtIndex:0];
    }
    SharePhoto *detail = [[SharePhoto alloc] init];
    detail.sharePhotoId = [_dic objectForKey:@"sharePhotoId"];
    
    detail.sharePhotoDes = [_dic objectForKey:@"sharePhotoDes"];
    
    detail.sharePhotoName = [_dic objectForKey:@"sharePhotoName"];
    
    detail.sharePhotoTime = [_dic objectForKey:@"sharePhotoTime"];
     //detail.sharePhotoRealPath = [NSString stringWithFormat:@"%@%@",@"http://119.57.54.48",[_dic objectForKey:@"headPhoto"]];//[_dic objectForKey:@"headPhoto"];
    detail.sharePhotoRealPath =  [_dic objectForKey:@"sharePhotoRealPath"];  
    
    detail.sharePhotoSmallPath = [_dic objectForKey:@"sharePhotoSmallPath"]; //  [_dic objectForKey:@"sharePhotoSmallPath"];
    return detail;
}
@end
