//
//  CommonUtils.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CommonUtils.h"
#import "AccountInfo.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "ReplyList.h"
#import "SinoNetMBProgressHUD.h"
#import "GroupList.h"
@implementation CommonUtils

static UIWindow * awindow;
static UIWindow * oldKeyWindow;
+(UIImage*)stretchableImageFromName:(NSString*)name{
    UIImage *image=[UIImage imageNamed:name];//绑定图片
    UIImage *imageNormal=[image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];//设置图片的拉伸样式，可以省略
    return imageNormal;
}


+(void)ShowErroringInView:(UIView*)view  WithErrorMessage:(NSString*)errorMessage   {
    
    [SinoNetMBProgressHUD hideHUDForView:view animated:YES];
    SinoNetMBProgressHUD *HUD = [SinoNetMBProgressHUD showHUDAddedTo:view animated:YES];// 
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]] autorelease];
	
    // Set custom view mode
    HUD.mode = SinoNetMBProgressHUDModeCustomView;
	
    //  HUD.delegate = self;
    HUD.labelText = [NSString stringWithFormat:@"%@",errorMessage];
	
    [HUD show:YES];
    
	[HUD hide:YES afterDelay:3];
}

+(AccountInfo*)loadAccountByUId:(NSString*)uId
{
    AccountInfo *accont;
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : USER_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:uId forKey:@"userId"];
    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    if (range.location == NSNotFound ) {
        // 如果 成功
        accont = [AccountInfo AccountWithNSDictionary:dictionary];
        //NSLog(@"jsondata ->%@",jsonData);
        //[data addObjectsFromArray:list.weiboList];
      //  NSLog(@"accont.nickname---->%@",[accont nickname]);
        
    } else { 
        // 如果 失败 
        
    }
    return accont; 
    
}

+(ReplyList*)loadReplyListByWeiboId:(NSString*)weiboId withPage:(int)page{
    
NSURL *tempurl = [[[ NSURL alloc ] initWithString : REPLY_URL  ] autorelease ];
ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
[request setPostValue:weiboId forKey:@"postsId"];
[request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];

[request setUseCookiePersistence : YES ];
//[request setDelegate:self];
[request startSynchronous ];


NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];

NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
NSError *error = nil;
NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
ReplyList *list = [ReplyList ReplyListWithNSDictionary:dictionary];

return list;
}
+(void)ShowWaitingView:(BOOL)isShow{
    if (isShow) {
        if (!awindow) {
            awindow=[[UIWindow alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
            awindow.windowLevel=UIWindowLevelStatusBar;
            
        }
        [SinoNetMBProgressHUD hideHUDForView:awindow animated:YES];
        SinoNetMBProgressHUD *_hud = [SinoNetMBProgressHUD showHUDAddedTo:awindow animated:YES];
        
        _hud.labelText = @"加载中...";
        oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
        [awindow makeKeyAndVisible];
    }
    else{
        if (awindow) {
            [awindow resignKeyWindow];
            [awindow setHidden:YES];
            [oldKeyWindow makeKeyWindow];
            [SinoNetMBProgressHUD hideHUDForView:awindow animated:YES];
        }
    }
}
+(WeiBoModel*)loadWeiBoModelByUId:(NSString*)uId
{
    WeiBoModel *weibo;
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBO_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:uId forKey:@"postsId"];
    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    //NSLog(@"dictionary -->%@",dictionary);
    if (range.location == NSNotFound ) {
        if ([dictionary objectForKey:@"weiboList"]&&[[dictionary objectForKey:@"weiboList"]  isKindOfClass:[NSArray class]]){
           weibo = [WeiBoModel WeiBoModelWithNSDictionary:[[dictionary objectForKey:@"weiboList"]objectAtIndex:0]];
        
        }
             
        // 如果 成功
        //NSLog(@"jsondata ->%@",jsonData);
        //[data addObjectsFromArray:list.weiboList];
       // NSLog(@"accont.nickname---->%@",[accont nickname]);
        
    } else { 
        // 如果 失败 
        
    }
    return weibo; 
    
}
+(NSString*)getRealHeadPhotoUrl:(NSString*)fakeUrl{
    NSMutableString *tempStr = [[NSMutableString alloc] initWithCapacity:0];
   // [tempStr appendString:SERVER_URL ];
    [tempStr appendFormat:fakeUrl];

    return [tempStr autorelease];
}



+(ReplyList*)loadAllReplyListForMeWithPage:(int)page{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBOLIST_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:@"8" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    //[request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadAllReplyListForMeWithPage %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    MessageReplyList *messageReplyList = [MessageReplyList MessageListWithNSDictionary: dictionary];
    ReplyList *list = [ReplyList ReplyListWithMessageReplyList: messageReplyList];
    
    return list;
}




+(WeiBoListModel*)loadWeiBoListModelAboutMe:(int)page{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:WEIBOLIST_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:@"7" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
   // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadWeiBoListModelAboutMe %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
   // MessageReplyList *messageReplyList = [MessageReplyList MessageListWithNSDictionary: dictionary];
    //ReplyList *list = [ReplyList ReplyListWithMessageReplyList: messageReplyList];
    WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
    
         
    return list;
    
}
+(WeiBoListModel*)loadPrivateWeiBoListModelAboutMe:(int)page{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:WEIBOLIST_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:@"9" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadWeiBoListModelAboutMe %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    // MessageReplyList *messageReplyList = [MessageReplyList MessageListWithNSDictionary: dictionary];
    //ReplyList *list = [ReplyList ReplyListWithMessageReplyList: messageReplyList];
    WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
    
    
    return list;
    
}
+(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr{
    
    
    
    NSString *date_string;
    
    
    
    NSDate *time_str;
    
    if( timeSeconds>0){
        
        time_str =[NSDate dateWithTimeIntervalSince1970:timeSeconds];
        
    }else{
        
        time_str=[[NSDate alloc] init];
        
    }
    
    
    
    if( timeFormatStr==nil){
        
        date_string =[NSString stringWithFormat:@"%d",(long)[time_str timeIntervalSince1970]];
        
    }else{
        
        NSDateFormatter *date_format_str =[[[NSDateFormatter alloc] init] autorelease];
        
        [date_format_str setDateFormat:timeFormatStr];
        
        if( timeZoneStr!=nil){
            
            [date_format_str setTimeZone:[NSTimeZone timeZoneWithName:timeZoneStr]];
            
        }
        
        date_string =[date_format_str stringFromDate:time_str];
        
    }
    
    
    
    return date_string;
    
}
+(void)RetweetWeiboWithAtWeiboId:(NSString*)weiboId andMesg:(NSString*)mesg
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:DIRECT_MESSAGE_URL   ] autorelease ];
    NSLog(@"weiboId --->%@",weiboId);
    NSLog(@"mesg --->%@",mesg);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:weiboId forKey:@"atWeiboId"]; 
    [request setPostValue:mesg forKey:@"mesg"];
    [request setPostValue:@"is" forKey:@"isSee"];
    [request setPostValue:@"2" forKey:@"comefrom_id"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>RetweetWeiboWithAtWeiboId %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }
    
}
+(void)ReplyWeiboWithWeiBoId:(NSString *)weiboId andContext:(NSString*)context
{

    NSURL *tempurl = [[[ NSURL alloc ] initWithString:REPLY_WEIBO_URL  ] autorelease ];
    NSLog(@"weiboId --->%@",weiboId);
    NSLog(@"context --->%@",context);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:weiboId forKey:@"id"]; 
    [request setPostValue:context forKey:@"context"];
    [request setPostValue:@"2" forKey:@"comefrom_id"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>ReplyWeiboWithWeiBoId %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }
}

+(void)shareWeiboById:(NSString *)weiboId
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHARE_WEIBO_URL  ] autorelease ];
    NSLog(@"weiboId --->%@",weiboId);
    //NSLog(@"context --->%@",context);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:weiboId forKey:@"id"]; 
    [request setPostValue:@"0" forKey:@"sendType"]; 
    [request setPostValue:@"分享成功" forKey:@"shareDescription"]; 
    [request setPostValue:@"" forKey:@"shareUrl"]; 
    
    
    // [request setPostValue:@"2" forKey:@"comefrom_id"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>shareWeiboById %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }
}
+( Bean *)delAttention:(NSString*)uid{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:UNFOLLOW_URL  ] autorelease ];
    
    NSLog(@"F_uid --->%@",uid);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:uid forKey:@"F_uid"]; 
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
     
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    Bean *b = [Bean BeanWithNSDictionary:dictionary];
    return b;
}
+(Bean *)addAttention:(NSString*)uid{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:FOLLOW_URL  ] autorelease ];
    
   NSLog(@"F_uid --->%@",uid);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:uid forKey:@"F_uid"]; 
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    Bean *b = [Bean BeanWithNSDictionary:dictionary];
    return b;
}
+(Bean*)updatePasswordWithOldPassword:(NSString *)oldPass andNewPassword:(NSString *)newPass andCheckPassword:(NSString *)checkPass
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:UPDATAPASSWORD_URL  ] autorelease ];
    
    NSLog(@"oldPass %@ newPass %@ checkPass %@",oldPass,newPass,checkPass);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:oldPass forKey:@"F_old_pwd"]; 
    [request setPostValue:newPass forKey:@"F_new_pwd"]; 
    [request setPostValue:checkPass forKey:@"F_check_pwd"]; 
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
   
    NSLog(@">>>>>>>>>>>>>>>>>>addAttention %@",html);
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    Bean *b = [Bean BeanWithNSDictionary:dictionary];
    return b;
    
}
+(void)updateUserInfo:(NSString *) sex andSproviceId:(NSString*) sproviceId andCityId:(NSString*)cityId andProfile:(NSString*)profile
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:UPDATAPASSWORD_URL  ] autorelease ];
    
    NSLog(@"sex %@ sproviceId %@ cityId %@ profile %@",sex,sproviceId,cityId,profile);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:sex forKey:@"D_sex"]; 
    [request setPostValue:sproviceId forKey:@"D_Sprovince"]; 
    [request setPostValue:cityId forKey:@"D_Scity"]; 
    [request setPostValue:profile forKey:@"D_profile"]; 
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@">>>>>>>>>>>>>>>>>>addAttention %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }else{
        
    }
}
+(void)deleteWeiboById:(NSString *)weiboId
{
    
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:DEL_WEIBO_URL  ] autorelease ];
    NSLog(@"weiboId --->%@",weiboId);
    //NSLog(@"context --->%@",context);
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:weiboId forKey:@"F_pid"]; 
   
   // [request setPostValue:@"2" forKey:@"comefrom_id"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>deleteWeiboById %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }

}
+(void)sendWeiBoWithMseg:(NSString *)mesg WithDianming:(NSString*)dianming 
        WithFlieNameData:(NSData *) fileData WithGroup:(NSString*)group WithIsSee:(NSString *)isSee 
 {

    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SEND_WEIBO_URL  ] autorelease ];
    NSString *d =[CommonUtils setTimeInt:0 setTimeFormat:@"yyMMddHHmmss" setTimeZome:@"GMT"];
     NSLog(@"d =======>%@",d);
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
     if (dianming) {
         [request setPostValue:dianming forKey:@"dianming"];//点名时留言区追加显示：#@金箫 #@李宛鑫 #@孙刚（用#@ + 姓名 + 空格，并且点名前部能输入信息，在空格后输入信息）是否是点名：dianming，如是则：dianming="dianming"，否则: dianming=""
     }
    [request setPostValue:isSee forKey:@"isSee"];//是否全站好友可见选项：如选中：isSee=”is” ,如未选中： isSee=”no”
    [request setPostValue:mesg forKey:@"mesg"];//留言内容：mesg（判断是否为空）
    if (fileData) {
         [request setPostValue:@"is" forKey:@"F_inserimg"];//F_inserimg ：是否插入图片：是F_inserimg=“is”，否F_inserimg=“”（或者不用传这个参数）
       //  [request setPostValue:@"is" forKey:@"file_name"];//File 文件对象
        [request setData:fileData withFileName:[NSString stringWithFormat:@"myphoto_%@.jpg",d] andContentType:@"image/jpeg" forKey:@"file_name"];
         
    }
     //[request setFile:@"" forKey:@"file_name"];
     request.postFormat = ASIMultipartFormDataPostFormat;
    if(group){
     [request setPostValue:group forKey:@"group"];//现则群组选项：group=选择的群的ID，用英文逗号分隔如：1,2,3
    }
    [request setPostValue:@"2" forKey:@"comefrom_id"];
  //  [request setPostValue:@"2" forKey:@"atWeiboId"];//需要转发微博时：atWeiboId：要转发微博的id
    [request setUseCookiePersistence : YES ];
    //[request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>sendDirectMessage %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }

}
+(void)sendDirectMessage:(NSString *)dianming mesg:(NSString*)mesg isSee:(NSString *)isSee{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:DIRECT_MESSAGE_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:dianming forKey:@"dianming"];
    [request setPostValue:isSee forKey:@"isSee"];
    [request setPostValue:mesg forKey:@"mesg"];
      [request setPostValue:@"2" forKey:@"comefrom_id"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    //NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>sendDirectMessage %@",html);
    if (![html isEqualToString:@""]||![html isEqualToString:@"<>"]) {
        
    }
    //NSError *error = nil;
    
//    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
//    LetterList *list = [LetterList LetterListWithNSDictionary:dictionary];
//    
    
   
    
}
+(LetterList*)loadLetterListModeByOtherUserId:(NSString*)otherUserId withPage:(int)page{

    NSURL *tempurl = [[[ NSURL alloc ] initWithString:LETTER_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:otherUserId forKey:@"otherId"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadLetterListModeByOtherUserId %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    LetterList *list = [LetterList LetterListWithNSDictionary:dictionary];
    
    
    return list;
    
}

+(FriendList*)loadFriendList:(int)page{

    NSURL *tempurl = [[[ NSURL alloc ] initWithString:FRIENDLIST_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    //[request setPostValue:@"9" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadFriendList %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
   
    FriendList *list = [FriendList FriendListWithNSDictionary:dictionary];
    
    
    return list;
}
+(AttentionList*)loadAttentionList:(int)page andUserId:(NSString*)userId{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:ATTENTION_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    //[request setPostValue:@"9" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadAttentionList %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    AttentionList *list = [AttentionList AttentionListWithNSDictionary:dictionary];
    
    
    return list;

}
+(FanList*)loadFanList:(int)page andUserId:(NSString*)userId{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:FAN_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
 
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadFanList %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    FanList *list = [FanList FanListModelWithNSDictionary:dictionary];
    
    
    return list;
    
} 
//+(ContactListBean*)loadContactListBean:(int)page andUserId:(NSString*)userId andCityId:(NSString*)cityId andSortType:(NSString*)sortType{
//    
//    NSURL *tempurl = [[[ NSURL alloc ] initWithString:CONTACTS_INFO_URL  ] autorelease ];
//    
//    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
//    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
//    [request setPostValue:[NSString stringWithFormat:@"%d",10] forKey:@"pageSize"];
//    
//    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
//    if (cityId) {
//        
//        [request setPostValue:[NSString stringWithFormat:@"%@",cityId] forKey:@"cityId"];
//    }
//    
//    [request setPostValue:[NSString stringWithFormat:@"%@",sortType] forKey:@"sortType"];
//    [request setUseCookiePersistence : YES ];
//    
//    [request startSynchronous ];
//    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
//    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
//    NSError *error = nil;
//    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
//    
//    ContactListBean *list = [ContactListBean ContactListBeanWithNSDictionary:dictionary];
//    
//    
//    return list;
//    
//}  

+(ContactListBean*)loadContactListBean:(int)page andUserId:(NSString*)userId andCityId:(NSString*)cityId andSortType:(NSString*)sortType{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:CONTACTS_INFO_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setPostValue:[NSString stringWithFormat:@"%d",10] forKey:@"pageSize"];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    if (cityId) {
        
        [request setPostValue:[NSString stringWithFormat:@"%@",cityId] forKey:@"cityId"];
    }
    
    [request setPostValue:[NSString stringWithFormat:@"%@",sortType] forKey:@"sortType"];
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    ContactListBean *list = [ContactListBean ContactListBeanWithNSDictionary:dictionary];
    
    
    return list;
    
}  
+(MapDataList*)loadContactForMapWithUserId:(NSString*)userId andCityId:(NSString*)cityId {

    
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:CONTACTS_MAP_INFO_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
   // [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
   // [request setPostValue:[NSString stringWithFormat:@"%d",10] forKey:@"pageSize"];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    if (cityId) {
        
        [request setPostValue:[NSString stringWithFormat:@"%@",cityId] forKey:@"cityId"];
    }
    
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactForMapWithUserId %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    MapDataList *list = [MapDataList MapDataListWithNSDictionary:dictionary];
    
    
    return list;
}

+(Bean*)updateUserInforWith:(NSString *)profile andSex:(NSString*)sex andSprovince:(NSString*)province andScity:(NSString*)city andHeadImageData:(NSData*)headImageData 
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:UPDATA_USER_INFO_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    NSString *d =[CommonUtils setTimeInt:0 setTimeFormat:@"yyMMddHHmmss" setTimeZome:@"GMT"];
    NSLog(@"d =======>%@",d);
    NSLog(@"profile = %@ sex = %@ province = %@ city = %@",profile,sex,province,city);
    [request setPostValue:profile forKey:@"D_profile"];
    [request setPostValue:sex forKey:@"D_sex"];
    [request setPostValue:province forKey:@"D_SProvince"];
    [request setPostValue:city forKey:@"D_SCity"];
    if (headImageData) {
        //[request setPostValue:@"is" forKey:@"F_inserimg"];//F_inserimg ：是否插入图片：是F_inserimg=“is”，否F_inserimg=“”（或者不用传这个参数）
        //  [request setPostValue:@"is" forKey:@"file_name"];//File 文件对象
        [request setData:[headImageData retain] withFileName:[NSString stringWithFormat:@"headphoto_%@.jpg",d] andContentType:@"image/jpeg" forKey:@"file_name"];
        
    }
    
    request.postFormat = ASIMultipartFormDataPostFormat;
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    NSLog(@"dictionary = %@",dictionary);
    Bean *b = [Bean BeanWithNSDictionary:dictionary]; ;
//    if (error) {
//        b =  [[Bean alloc] init];
//        b.err=@"2";
//        b.msg = @"操作失败！原因未知！";
//    }else{
//        b = [Bean BeanWithNSDictionary:dictionary]; 
//    }
    return b;
    
}

+(Bean*)getCheckNumber:(NSString *)D_icode
{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:REGISTER_SENDCODE_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:D_icode forKey:@"D_icode"]; 
     
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    Bean *b = [Bean BeanWithNSDictionary:dictionary];
    return b;

}
+(Bean*)registerUserWithPhone:(NSString*)cRegPhone withName:(NSString*)name withPassword:(NSString*)password withIcode:(NSString*)cIcode withCitype:(int)index{
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:REGISTER_USER_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:cRegPhone forKey:@"C_regPhone"]; 
    
    [request setPostValue:name forKey:@"C_trueName"]; 
    
    [request setPostValue:password forKey:@"C_password"]; 
    
    [request setPostValue:cIcode forKey:@"C_icode"]; 
    if (index==0) {
        [request setPostValue:@"投资" forKey:@"C_iType"]; 
    }else if(index ==1)
    {
        [request setPostValue:@"融资" forKey:@"C_iType"]; 
    }
   
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    Bean *b = [Bean BeanWithNSDictionary:dictionary];
    return b;

    
}

+(FriendObject*)loadFriendObjectWithUserId:(NSString*)friendId{

    NSURL *tempurl = [[[ NSURL alloc ] initWithString:CONTACTS_CARD_INFO_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[GlobalInfo sharedGlobalInfo].userId forKey:@"userId"]; 
    
    [request setPostValue:friendId forKey:@"F_id"]; 
    
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    FriendObject *b = [FriendObject FriendObjectWithNSDictionary:dictionary];
    return b;
 
}

+(NSString *)saveShakePostionUserId:(NSString*)userId WithLongitude:(NSString *)log WithLatitude:(NSString *) lat{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHAKE_LOCATION_INFO_URL] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setPostValue:[NSString stringWithFormat:@"%@",log] forKey:@"longitude"];
    [request setPostValue:[NSString stringWithFormat:@"%@",lat] forKey:@"latitude"];
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    NSString * backStr=nil;
    if (dictionary) {
        backStr = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"msg"]];
    }
    return backStr;
} 
+(NSString *)deleteShakeHistoryUserId:(NSString*)userId{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHAKE_Delete_INFO_URL] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    NSString * backStr=nil;
    if (dictionary) {
        backStr = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"msg"]];
    }
    return backStr;
}

+(ShakeListBean *)shakeHistoryWithUserId:(NSString*)userId {
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHAKE_HISTORY_INFO_URL] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    ShakeListBean *list = [ShakeListBean ShakeListBeanWithNSDictionary:dictionary];
    return list;
}
+(ShakeListBean*)loadShakePersonListBeanUserId:(NSString*)userId {
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHAKE_SHAKE_INFO_URL] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    ShakeListBean *list = [ShakeListBean ShakeListBeanWithNSDictionary:dictionary];
    
    
    return list;
    
} 
+(NSString *)getGPSPointBy:(NSString*)pName andCName:(NSString*)cName
{
   NSLog(@"pName = %@,cName = %@",pName,cName);
//    NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@ %@&output=csv",pName,cName];
//    NSLog(@"url = %@",url);
//    NSURL *tempurl = [[[ NSURL alloc ] initWithString:@"http://maps.google.com/maps/geo" ]autorelease] ;
//    
//    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
//    [request setPostValue:[NSString stringWithFormat:@"%@%20%@",pName,cName] forKey:@"q"];
//    [request setPostValue:@"csv" forKey:@"output"];
// 
//    [request startSynchronous ];
//    
//    NSString *temp = [request responseString];
    NSString *encodedString =[NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@ %@&output=csv",pName,cName];
    NSLog(@"encodedString = %@",encodedString);
    NSString *encodedValue = [encodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
    NSURL *url = [NSURL URLWithString: encodedValue];
   
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
     
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *response=@"";
    if (!error) {
        response = [request responseString];
    } else{
    
        NSLog(@"error = %@",error);
    }
 // componentsSeparatedByString
    NSLog(@"temp = %@",response);
    return response;

 
}
+(CommonFriendListBean*)loadFriendObjectWithFriendType:(NSString *)searchText cityId:(NSString *)cityId pageNo:(NSString*)pageNo pageSize:(NSString *)pageSize friendType:(NSString*)friendType {
    NSURL *tempurl=[[NSURL alloc]init];
    
    NSLog(@"searchText=%@,cityId=%@,pageNo=%@,pageSize=%@,friendType=%@",searchText,cityId,pageNo,pageSize,friendType);
    
    if ([friendType isEqualToString:@"2"]) {
        tempurl=[NSURL URLWithString:CONTACTS_FRIENTBYCITY_INFO_URL];
    }
    else{
        tempurl=[NSURL URLWithString:CONTACTS_FRIENTTYPE_INFO_URL];
    }
    //    NSURL *tempurl = [[[ NSURL alloc ] initWithString:CONTACTS_FRIENTTYPE_INFO_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[GlobalInfo sharedGlobalInfo].userId forKey:@"userId"];
    if ([friendType isEqualToString:@"2"]) {
        [request setPostValue:searchText forKey:@"provinceName"];
        [request setPostValue:cityId forKey:@"cityName"];
    }
    else{
        [request setPostValue:searchText forKey:@"searchText"];
        [request setPostValue:friendType forKey:@"findType"];
    }
    
    //    [request setPostValue:cityId forKey:@"cityId"];
    [request setPostValue:pageNo forKey:@"pageNo"];
    [request setPostValue:pageSize forKey:@"pageSize"];
    
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    NSLog(@"dictionary = %@",dictionary);
    CommonFriendListBean *list = [CommonFriendListBean CommonFriendListBeanWithNSDictionary:dictionary];
    // FriendList *b = [FriendList FriendListWithNSDictionary:dictionary];
    return list;
    
}

+(MapDataList*)loadFriendMapObjectWithFriendType:(NSString *)searchText cityId:(NSString *)cityId friendType:(NSString*)friendType {
    NSURL *tempurl=[[NSURL alloc]init];
    tempurl=[NSURL URLWithString:CONTACTS_FRIENTMAPTYPE_INFO_URL];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[GlobalInfo sharedGlobalInfo].userId forKey:@"userId"];
    //    [request setPostValue:cityId forKey:@"cityId"];
    if (cityId) {
        [request setPostValue:cityId forKey:@"cityId"];
    }
    [request setPostValue:searchText forKey:@"searchText"];
    [request setPostValue:friendType forKey:@"findType"];
    
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    NSLog(@"dictionary = %@",dictionary);
    MapDataList *list = [MapDataList MapDataListWithNSDictionary:dictionary];
    return list;
}

+(CommonFriendListBean*)loadFriendObjectWithCity:(NSString *)provinceName cityId:(NSString *)cityId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize friendType:(NSString *)friendType{
    NSLog(@"provinceName=%@,cityId=%@,pageNo=%@,pageSize=%@,friendType=%@",provinceName,cityId,pageNo,pageSize,friendType);
    
    NSURL *tempurl=[[NSURL alloc]init];
    tempurl=[NSURL URLWithString:CONTACTS_FRIENTLISTBYCITY_INFO_URL];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[GlobalInfo sharedGlobalInfo].userId forKey:@"userId"];
    [request setPostValue:provinceName forKey:@"provinceName"];
    [request setPostValue:cityId forKey:@"cityName"];
    [request setPostValue:pageNo forKey:@"pageNo"];
    [request setPostValue:pageSize forKey:@"pageSize"];
    [request setPostValue:friendType forKey:@"findType"];
    
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    NSLog(@"dictionary = %@",dictionary);
    CommonFriendListBean *list = [CommonFriendListBean CommonFriendListBeanWithNSDictionary:dictionary];
    return list;
}


/*
 •	获取验证码输入参数：
 D_icode（手机号）
 •	注册输入参数：
 手机号：C_regPhone（校验手机号是否正确）
 真实姓名：C_trueName（非空校验）
 密码：C_password（非空校验）
 验证码：C_icode（发送后按钮不可用，超过一分钟需重新获取）
 投资融资：C_iType=”投资"    ,C_iType=”融资"（非空校验）
 1.3 返回数据
 */


+(GroupList*)loadGroupList:(int)page{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:GROUPLIST_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    //[request setPostValue:@"9" forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    // [request setDelegate:self];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadGroupList %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    GroupList *list = [GroupList GroupListWithNSDictionary:dictionary];
    
    
    return list;
}

+(time_t)getTimeValueForNSString:(NSString *)stringTime defaultValue:(time_t)defaultValue {
	//NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
	struct tm created;
    time_t now;
    time(&now);
    
	if (stringTime) {
        
        if (strptime([stringTime UTF8String], "%Y-%m-%d %H:%M:%S", &created) == NULL) {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
        //		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
        //			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        //		}
		return mktime(&created);
	}
	return defaultValue;
}
#define USERS_LOGIN_INFO @"USERS_LOGIN_INFO"

#define USERS_LOGIN_USERNAME @"kUserName"

#define USERS_LOGIN_PASSWORD @"KPassword"

+(void)saveLoginInfoByUserName:(NSString*)username andPassword:(NSString*)password{

    NSUserDefaults *defaultUser = [NSUserDefaults  standardUserDefaults];
    if ([defaultUser objectForKey:USERS_LOGIN_INFO]) {
        NSDictionary *dict= [defaultUser objectForKey:USERS_LOGIN_INFO];
        [dict setValue:password forKey:username];
        [defaultUser setValue:dict forKey:USERS_LOGIN_INFO];
    }else{
        NSDictionary *dict= [[NSDictionary alloc] init]; 
        [dict setValue:password forKey:username];
        [defaultUser setValue:dict forKey:USERS_LOGIN_INFO];
    }
        
}
+(NSDictionary*)getUserInfoForNSUserDefaults
{
    NSUserDefaults *defaultUser = [NSUserDefaults  standardUserDefaults];
    if ([defaultUser objectForKey:USERS_LOGIN_INFO]) {
        NSDictionary *dict= [defaultUser objectForKey:USERS_LOGIN_INFO];
        
        return [dict retain];
    }else{
    
        return nil;
    }

}
+(ShakeListBean*)loadShakeListBeanUserId:(NSString*)userId {
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString:SHAKE_LIST_INFO_URL  ] autorelease ];
    
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    
    [request setPostValue:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    [request setUseCookiePersistence : YES ];
    
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@">>>>>>>>>>>>>>>>>>loadContactListBean %@",html);
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    ShakeListBean *list = [ShakeListBean ShakeListBeanWithNSDictionary:dictionary];
    
    
    return list;
    
} 
 


@end
