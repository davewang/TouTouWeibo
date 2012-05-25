//
//  UserProfileImageView.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-26.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfo.h"
#import "ImageDownloader.h"
#import "TweetImageStyle.h"
#import "ImageDownloadReceiver.h"

@interface UserProfileImageView : UIButton {
    AccountInfo*               user;
	CGRect profileImageRect;	
	UIImage *profileImage;
	ImageDownloader *downloader;
    ImageDownloadReceiver*     _receiver;	
   
}

@property (nonatomic, retain) AccountInfo*      user;
@property (nonatomic, assign) CGRect profileImageRect;

@end
