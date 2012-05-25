//
//  Reply.m
//  toutou
//
//  Created by Allan on 12-3-4.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Reply.h"


@implementation Reply

@synthesize replyPhoto,replyContext,postsId,replyTime,replyOfUserName;
@synthesize createdAt;
@synthesize timeString;
- (NSString*)timestamp
{
    if (replyTime) {

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
    }else{
        return nil;
    }
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
+(Reply*)ReplyWithMessageReply:(MessageReply*)mr
{
    Reply *r = [[Reply alloc] init];
	r.replyPhoto = mr.headPhoto;
	r.replyContext = mr.mContent;// [_dic objectForKey:@"replyContext"];
	r.postsId = mr.mId;//[_dic objectForKey:@"postsId"];
	r.replyTime =  mr.postTime;
	r.replyOfUserName = mr.userName;
    r.createdAt = [CommonUtils  getTimeValueForNSString:mr.postTime defaultValue:0];
	return r;
}
+(Reply*)ReplyWithFanBean:(FanBean*)mr
{
    Reply *r = [[Reply alloc] init];
	r.replyPhoto = mr.headPhoto;
	r.replyContext = mr.context;// [_dic objectForKey:@"replyContext"];
	r.postsId = mr.fanOfUserId;//[_dic objectForKey:@"postsId"];
    r.replyOfUserName = mr.fanOfUserName;
	return r;
}
+(Reply*)ReplyWithAttention:(Attention*)mr
{
    Reply *r = [[Reply alloc] init];
	r.replyPhoto = mr.headPhoto;
	r.replyContext = mr.context;// [_dic objectForKey:@"replyContext"];
	r.postsId = mr.attOfUserId;//[_dic objectForKey:@"postsId"];
    r.replyOfUserName = mr.attOfUserName;
    
	return r;
}




+(Reply*)ReplyWithNSDictionary:(NSDictionary *)_dic
{
	Reply *r = [[Reply alloc] init];
	r.replyPhoto = [CommonUtils getRealHeadPhotoUrl:[_dic objectForKey:@"replyPhoto"] ];
	r.replyContext = [_dic objectForKey:@"replyContext"];
	r.postsId = [_dic objectForKey:@"postsId"];
	r.replyTime = [_dic objectForKey:@"replyTime"];
	r.replyOfUserName = [_dic objectForKey:@"replyOfUserName"];
    r.createdAt = [_dic getTimeValueForKey:@"replyTime" defaultValue:0];
	return r;
}

+(Reply*)ReplyWithWeiboModel:(WeiBoModel*)wbm{
    Reply *r = [[Reply alloc] init];
	r.replyPhoto =  wbm.headPhoto;
	r.replyContext = wbm.mContent;
	r.postsId = wbm.uid;
	r.replyTime =  wbm.postTime;
	r.replyOfUserName = wbm.userName;
    r.createdAt =[CommonUtils  getTimeValueForNSString:wbm.postTime defaultValue:0];
	return r;

}
@end
