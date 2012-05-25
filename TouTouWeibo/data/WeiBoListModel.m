//
//  WeiBoListModel.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "WeiBoListModel.h"
 
#import "WeiBoModel.h"
@implementation WeiBoListModel
@synthesize  pageInfo,err,weiboList,name,uid;

+(WeiBoListModel*)WeiBoListModelWithNSDictionary:(NSDictionary*)_dic{
    WeiBoListModel *detail = [[WeiBoListModel alloc] init];
//    detail.userNick = [dic objectForKey:@"userNick"];
//    detail.userId = [dic objectForKey:@"userId"];
//    detail.userEmail = [dic objectForKey:@"userEmail"];
//    detail.userName = [dic objectForKey:@"userName"];
    
    detail.weiboList = [[NSMutableArray alloc] initWithCapacity:2];
    for(NSDictionary *_tDic in [_dic objectForKey:@"weiboList"] )
    { 
        
        [detail.weiboList addObject:[WeiBoModel WeiBoModelWithNSDictionary:_tDic]];
    }
    
    detail.name = [[ _dic objectForKey:@"userInfo"] objectForKey:@"name"];
    detail.pageInfo =  [Page PageWithNSDictionary:[_dic objectForKey:@"pageInfo"] ];//[_dic objectForKey:@"pageInfo"];//new PageBean(root.getJSONObject("pageInfo"));
    if([detail.name isEqualToString:@""] || detail.name ==nil){
        detail.name = @"微博";
    }
    detail.uid = [[ _dic objectForKey:@"userInfo"] objectForKey:@"id"];;//root.getJSONObject("userInfo").getString("id");
    [_dic objectForKey:@"weiboList"];
    
    NSLog(@"weibolist.name = %@",detail.name );
    
    NSLog(@"weibolist.uid = %@",detail.uid );
    return detail;
    
} 
@end
