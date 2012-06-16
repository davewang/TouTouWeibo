//
//  WeiBoModel.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-29.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "WeiBoModel.h"
#import "NSDictionaryAdditions.h"

@implementation WeiBoModel
@synthesize err,uid,actionDescription,headPhoto,userId,userName,mId,mContent,postTime,postTitle,total;
@synthesize statusId;
@synthesize shareUrl,sharePhoto;
@synthesize createdAt;
@synthesize timeString;
@synthesize _mFrom,_trans,_fromId,_isForm,_fromDes,_fromName,_fromTime,_fromTotal,_fromTrans,_fromUserId,_fromRealPath;
@synthesize _fromUserName,_fromSmallPath;
- (NSString*)timestamp
{
	NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {  
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }  
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];        
        _timestamp = [dateFormatter stringFromDate:date];
    }
   return _timestamp;
}

- (NSString *)timeString {
	if (!_timeString) {
		static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];        
        _timeString = [[dateFormatter stringFromDate:date] copy];
	}
	return _timeString;
}
+(WeiBoModel*)WeiBoModelWithNSDictionary:(NSDictionary*)_dic{
    WeiBoModel *weibo = [[WeiBoModel alloc] init];
    
  //  weibo.uid = [_dic objectForKey:@"id"];
  
    
     
    if ([_dic objectForKey:@"headPhoto" ] && ![[_dic objectForKey:@"headPhoto" ] isEqual:@""]) {
       // weibo.headPhoto = [NSString stringWithFormat:@"%@%@",@"http://119.57.54.48",[_dic objectForKey:@"headPhoto"]]; 
         weibo.headPhoto =  [_dic objectForKey:@"headPhoto"]; 
    }
   
   
    weibo.userId = [_dic objectForKey:@"userId"];//[_dic objectForKey:@"userId");
    weibo.userName = [_dic objectForKey:@"userName"];//[_dic objectForKey:@"userName");
    weibo.mId = [_dic objectForKey:@"mId"];//[_dic objectForKey:@"mId");
    weibo.mContent = [_dic objectForKey:@"mContent"];//[_dic objectForKey:@"mContent");
    weibo.postTime = [_dic objectForKey:@"postTime"];//[_dic objectForKey:@"postTime");
    weibo.postTitle = [_dic objectForKey:@"postTitle"];//[_dic objectForKey:@"postTitle");
    weibo.total = [_dic objectForKey:@"total"];//[_dic objectForKey:@"total");
    weibo.createdAt = [_dic getTimeValueForKey:@"postTime" defaultValue:0];
    weibo.actionDescription = [_dic objectForKey:@"actionDescription"];
    if (!weibo.actionDescription) {
        weibo.actionDescription = @"发布微博";
    }
    if([_dic objectForKey:@"id"]){
        weibo.uid = [_dic objectForKey:@"id"];
    }else{
        weibo.uid = @"";
    }
    if([_dic objectForKey:@"sharePhoto"]){
        
        
        weibo.sharePhoto = [SharePhoto SharePhotoWithNSDictionary: [_dic objectForKey:@"sharePhoto"]];
        
        NSString  *tmpStr = weibo.sharePhoto.sharePhotoDes;
        if(tmpStr && ![tmpStr isEqualToString:@""]){
            weibo.mContent = tmpStr;
        }
    } 
    if([_dic objectForKey:@"shareUrl"]){
        weibo.shareUrl =[ShareUrl ShareUrlWithNSDictionary:[_dic objectForKey:@"shareUrl"]];
    } 
    weibo.statusId = weibo.mId;
    
    
    
    
    weibo._mFrom = [_dic objectForKey:@"mFrom"];//微薄来源
    weibo._trans = [_dic objectForKey:@"trans"];//转发数
    
    if([_dic objectForKey:@"from"]){
        
        NSDictionary *temDic = [[_dic objectForKey:@"from"] objectAtIndex:0];
        
        weibo._isForm = YES;
        weibo._fromDes = [temDic objectForKey:@"fromDes"];
        weibo._fromId = [temDic objectForKey:@"fromId"];
        weibo._fromName = [temDic objectForKey:@"fromName"];
        if([temDic objectForKey:@"fromSmallPath"]){
            weibo._fromSmallPath = [temDic objectForKey:@"fromSmallPath"];
        }else{
            weibo._fromSmallPath = @"";
        }
         
        weibo._fromRealPath = [temDic objectForKey:@"fromRealPath"];
        weibo._fromTime = [temDic objectForKey:@"fromTime"];
        weibo._fromTotal = [temDic objectForKey:@"fromTotal"];//回复数
        NSLog(@"mContent ----->%@",  weibo.mContent);
        NSLog(@"fromTotal ----->%@", [temDic objectForKey:@"fromTotal"]);
        weibo._fromTrans = [temDic objectForKey:@"fromTrans"];//转发数
        weibo._fromUserId = [temDic objectForKey:@"fromUserId"];
        weibo._fromUserName = [temDic objectForKey:@"fromUserName"];
    }else{
        weibo._isForm = NO;
    }
    
 
    return weibo;
    
}
 
@end
