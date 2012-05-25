//
//  UserCell.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "ImageDownloader.h"
#import "TweetImageStyle.h"
#import "ImageDownloadReceiver.h"
#import "Attention.h"
@interface UserCell : UITableViewCell {
	Attention*               user;
	UIImage *profileImage;
	ImageDownloader *downloader;
    ImageDownloadReceiver*     _receiver;
}

@property(nonatomic, retain) Attention*      user;

@end
