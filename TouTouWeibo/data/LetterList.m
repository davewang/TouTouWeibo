//
//  LetterList.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "LetterList.h"

@implementation LetterList
@synthesize err,pageInfo,weiboList;
+(LetterList*)LetterListWithNSDictionary:(NSDictionary*)_dic
{
    LetterList *letterList =[[LetterList alloc] init];
    if (![_dic  objectForKey:@"err"]) {
        letterList.err = @"SUCCESS";
    }else{
        letterList.err = [_dic  objectForKey:@"err"];
    }
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    for (NSDictionary *tmp in [_dic  objectForKey:@"weiboList"] ) {
        
        [arr addObject: [Letter  LetterWithNSDictionary:tmp]];
    }
    letterList.weiboList = arr;
    [arr release];
    letterList.pageInfo = [Page PageWithNSDictionary:  [_dic  objectForKey:@"pageInfo"]];
   
    return letterList;
}
@end
