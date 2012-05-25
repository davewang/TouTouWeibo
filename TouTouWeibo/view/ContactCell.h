//
//  ContactCell.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
{
    IBOutlet UILabel *name;
    IBOutlet UILabel *className;
    IBOutlet UILabel *mobileNumber;
    IBOutlet UIImageView *headImageView;
    IBOutlet UIImageView *sexImageView;
    NSString *headUrl;
    ImageDownloader *downloader;
    ImageDownloadReceiver*     _receiver;	
    UIImage *profileImage;
   // UIImage *imgMale;
    //UIImage *imgFemale;
}
@property(nonatomic,assign)UILabel *name;
@property(nonatomic,assign)UILabel *className;
@property(nonatomic,assign)UILabel *mobileNumber;
@property(nonatomic,assign)UIImageView *headImageView;
 
-(void)setSex:(NSString*)sex;
-(void)setHeadUrl:(NSString*)headUrl;
- (UIImage*)downloadImage ;
@end
