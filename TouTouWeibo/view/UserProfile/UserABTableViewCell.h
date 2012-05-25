//
//  UserABTableViewCell.h
//  ZhiWeibo
//
//  Created by junmin liu on 11-1-3.
//  Copyright 2011 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABTableViewCell.h"
#import "AccountInfo.h"
#import "ImageDownloader.h"
#import "TweetImageStyle.h"
#import "ImageDownloadReceiver.h"

@interface UserABTableViewCell : ABTableViewCell {
	CGRect profileImageRect;	
	AccountInfo*               user;
	UIImage *profileImage;
	ImageDownloader *downloader;
    ImageDownloadReceiver*     _receiver;	
}

@property(nonatomic, retain) AccountInfo*      user;
@property (nonatomic, assign) CGRect profileImageRect;

@end
