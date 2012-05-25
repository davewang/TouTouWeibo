//
//  UpdateUserProfileViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-14.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfo.h"

#import "ImageDownloader.h"
#import "TweetImageStyle.h"
#import "UserEditeDetailViewController.h"
#import "ImageDownloadReceiver.h"
#import "DWCheckBoxView.h" 
#import "IndustryPickerView.h"
@interface UpdateUserProfileViewController:BaseUIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UserEditeDetailViewControllerDelegate,IndustryPickerViewDelegate>
{
    AccountInfo *account;
    UITableView *tableView;
    UIFont *detailCellFont;
	UIFont *cellFont;
    ImageDownloader *downloader;
    ImageDownloadReceiver*     _receiver;	
    UIImage *profileImage;
    IBOutlet UserEditeDetailViewController *detailView;
    DWCheckBoxView *boxView;
    NSString *currentRegion;
    NSString *currentInfomation;
    NSString *currentOftenAddressId;
    NSString *currentoftenAddressOfProvinceId;
    IndustryPickerView *pickerView;
    int  currentSexIndex;
    NSData *currentHeadImage;
}  

//@property(retain,nonatomic) IBOutlet UserEditeDetailViewController *detailView;
@property(retain,nonatomic) IBOutlet UITableView *tableView;
@property(retain,nonatomic)AccountInfo *account;
@property(retain,nonatomic)NSString *currentInfomation;
- (UIImage*)processStyle:(UIImage*)_image;
@end
