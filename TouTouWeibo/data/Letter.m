//
//  Letter.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "Letter.h"

@implementation Letter
@synthesize userId,headPhoto,postTime,postTitle,isSelf,isSending;
+(Letter*)LetterWithNSDictionary:(NSDictionary*)_dic
{
    Letter *letter = [[Letter alloc] init];
    
    letter.userId = [_dic objectForKey:@"userId" ];
    
    if([letter.userId isEqualToString:[GlobalInfo sharedGlobalInfo].userId]){
        letter.isSelf = YES;
    }else{
        letter.isSelf = NO;
    }
    letter.headPhoto = [_dic objectForKey:@"headPhoto" ]; //jsonObject.getString("headPhoto");
    letter.postTime = [_dic objectForKey:@"postTime" ];//jsonObject.getString("postTime");
    letter.postTitle = [_dic objectForKey:@"postTitle" ];//jsonObject.getString("postTitle");

    
   
    return letter;
}
@end
