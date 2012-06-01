//
//  CommonUtils.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "WeiBoModel.h"
#import "MessageReplyList.h"
#import "WeiBoListModel.h"
#import "LetterList.h"
#import "FriendList.h"
#import "GroupList.h"
#import "FanList.h"
#import "Bean.h"
#import "AttentionList.h"
#import "ContactListBean.h"
#import "MapData.h"
#import "MapDataList.h"
#import "FriendObject.h"
#import "ShakeListBean.h"
#import "CommonFriendListBean.h"
@class ReplyList;
@class ClassInfoList;
@interface CommonUtils : NSObject
{

}

+(void)ShowErroringInView:(UIView*)view  WithErrorMessage:(NSString*)errorMessage;
//+(void)addAttention:(NSString*)uid;
+(Bean *)addAttention:(NSString*)uid;
+(Bean*)delAttention:(NSString*)uid;
//+(void)delAttention:(NSString*)uid;
+(UIImage*)stretchableImageFromName:(NSString*)name;
+(AttentionList*)loadAttentionList:(int)page andUserId:(NSString*)userId;
+(AccountInfo*)loadAccountByUId:(NSString*)uId;
+(FanList*)loadFanList:(int)page andUserId:(NSString*)userId;
+(WeiBoModel*)loadWeiBoModelByUId:(NSString*)uId; 
+(ReplyList*)loadReplyListByWeiboId:(NSString*)weiboId withPage:(int)page;
+(ReplyList*)loadAllReplyListForMeWithPage:(int)page;
+(time_t)getTimeValueForNSString:(NSString *)stringTime defaultValue:(time_t)defaultValue;
+(NSString*)getRealHeadPhotoUrl:(NSString*)fakeUrl;
+(WeiBoListModel*)loadWeiBoListModelAboutMe:(int)page; 
+(WeiBoListModel*)loadPrivateWeiBoListModelAboutMe:(int)page;
+(LetterList*)loadLetterListModeByOtherUserId:(NSString*)otherUserId withPage:(int)page;
+(FriendList*)loadFriendList:(int)page;

+(GroupList*)loadGroupList:(int)page;
//+( *) :(int)page; 
+(void)ShowWaitingView:(BOOL)isShow;
+(void)sendDirectMessage:(NSString *)dianming mesg:(NSString*)mesg isSee:(NSString *)isSee;

+(void)saveLoginInfoByUserName:(NSString*)username andPassword:(NSString*)password;
+(NSDictionary*)getUserInfoForNSUserDefaults;


+(void)sendWeiBoWithMseg:(NSString *)mesg WithDianming:(NSString*)dianming 
        WithFlieNameData:(NSData *) fileData WithGroup:(NSString*)group WithIsSee:(NSString *)isSee ;


+(void)ReplyWeiboWithWeiBoId:(NSString *)weiboId andContext:(NSString*)context;
+(void)RetweetWeiboWithAtWeiboId:(NSString*)weiboId andMesg:(NSString*)mesg;

+(void)deleteWeiboById:(NSString *)weiboId;

+(Bean*)getCheckNumber:(NSString *)D_icode;

+(Bean*)registerUserWithPhone:(NSString*)cRegPhone withName:(NSString*)name withPassword:(NSString*)password withIcode:(NSString*)cIcode withCitype:(int)index;


+(void)shareWeiboById:(NSString *)weiboId;
+(Bean*)updatePasswordWithOldPassword:(NSString *)oldPass andNewPassword:(NSString *)newPass andCheckPassword:(NSString *)checkPass;

+(Bean*)updateUserInforWith:(NSString *)profile andSex:(NSString*)sex andSprovince:(NSString*)province andScity:(NSString*)city andHeadImageData:(NSData*)headImageData ;

+(ContactListBean*)loadContactListBean:(int)page andUserId:(NSString*)userId
                             andCityId:(NSString*)cityId andSortType:(NSString*)sortType;


+(MapDataList*)loadContactForMapWithUserId:(NSString*)userId andCityId:(NSString*)cityId;

+(FriendObject*)loadFriendObjectWithUserId:(NSString*)userId;

+(NSString *)saveShakePostionUserId:(NSString*)userId WithLongitude:(NSString *)log WithLatitude:(NSString *) lat;
+(ShakeListBean*)loadShakePersonListBeanUserId:(NSString*)userId;
+(ShakeListBean *)shakeHistoryWithUserId:(NSString*)userId;
+(NSString *)deleteShakeHistoryUserId:(NSString*)userId;
+(ShakeListBean*)loadShakeListBeanUserId:(NSString*)userId;



+(CommonFriendListBean*)loadFriendObjectWithFriendType:(NSString *)searchText cityId:(NSString *)cityId pageNo:(NSString*)pageNo pageSize:(NSString *)pageSize friendType:(NSString*)friendType;

+(MapDataList*)loadFriendMapObjectWithFriendType:(NSString *)searchText cityId:(NSString *)cityId friendType:(NSString*)friendType;

+(CommonFriendListBean*)loadFriendObjectWithCity:(NSString *)provinceName cityId:(NSString *)cityId pageNo:(NSString*)pageNo pageSize:(NSString *)pageSize friendType:(NSString*)friendType;

+(NSString *)getGPSPointBy:(NSString*)pName andCName:(NSString*)cName;

+(ClassInfoList*)loadClassInfoList:(int)page;
@end
