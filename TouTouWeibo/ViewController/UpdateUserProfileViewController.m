//
//  UpdateUserProfileViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-14.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "UpdateUserProfileViewController.h"

#import "UIDevice-hardware.h"
#import "Reachability2.h"
#import "IndustryPickerView.h"
@implementation UpdateUserProfileViewController
@synthesize tableView;
@synthesize account;
@synthesize currentInfomation;

static UIImage *defaultProfileImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!defaultProfileImage) {
			defaultProfileImage = [[UIImage imageNamed:@"ProfilePlaceholderOverWhite.png"] retain];
		}
        downloader = [ImageDownloader downloaderWithName:@"profileImages"];
        _receiver = [[ImageDownloadReceiver alloc] init];
        _receiver.imageContainer = self;
    }
    return self;
}

- (void)showImagePicker:(BOOL)hasCamera
{
    UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
    //picker.composeView = self;
    picker.allowsEditing =YES;
    picker.delegate = self;
    if (hasCamera) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentModalViewController:picker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[self performSelectorInBackground:@selector(compressImageInBackground:) 
						   withObject:image];
	
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
	
    [self dismissModalViewControllerAnimated:true];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // do nothing here
}

- (UIImage *)resizeImage:(UIImage *)original toSize:(MediaResize)resize {
	CGSize smallSize, mediumSize, largeSize, originalSize;
	UIImageOrientation orientation = original.imageOrientation; 
 	switch (orientation) { 
		case UIImageOrientationUp: 
		case UIImageOrientationUpMirrored:
		case UIImageOrientationDown: 
		case UIImageOrientationDownMirrored:
			smallSize = CGSizeMake(480, 320);
			mediumSize = CGSizeMake(960, 640);
			largeSize = CGSizeMake(1600, 1066);
			if([[UIDevice currentDevice] platformString] == IPHONE_4G_NAMESTRING)
				originalSize = CGSizeMake(2592, 1936);
			else if([[UIDevice currentDevice] platformString] == IPHONE_3GS_NAMESTRING)
				originalSize = CGSizeMake(2048, 1536);
			else
				originalSize = CGSizeMake(1600, 1200);
			break;
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			smallSize = CGSizeMake(320, 480);
			mediumSize = CGSizeMake(640, 960);
			largeSize = CGSizeMake(1066, 1600);
			if([[UIDevice currentDevice] platformString] == IPHONE_4G_NAMESTRING)
				originalSize = CGSizeMake(1936, 2592);
			else if([[UIDevice currentDevice] platformString] == IPHONE_3GS_NAMESTRING)
				originalSize = CGSizeMake(1536, 2048);
			else
				originalSize = CGSizeMake(1200, 1600);
	}
	
	// Resize the image using the selected dimensions
	UIImage *resizedImage = original;
	switch (resize) {
		case kResizeSmall:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:smallSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeMedium:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:mediumSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeLarge:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:largeSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeOriginal:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:originalSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
	}
	return resizedImage;
}

- (void) compressImageInBackground:(UIImage *)image {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	int size = kResizeMedium;
	
	NetworkStatus connectionStatus = [[Reachability2 sharedReachability] internetConnectionStatus];
	if (connectionStatus == ReachableViaWiFiNetwork) { //WIFI 大图
		size = kResizeSmall;
	}	else {
		size = kResizeSmall;
	}
    
    
	UIImage *postImage = [self resizeImage:image toSize:size];
	/*
     CGFloat maxSize = 768;
     if ((maxSize < image.size.width || maxSize < image.size.height) ||
     image.imageOrientation != UIImageOrientationUp)
     postImage = [image imageScaledToSizeWithSameAspectRatio:CGSizeMake(maxSize, maxSize)];
     else {
     postImage = image;
     }
	 */
    
    currentHeadImage = UIImagePNGRepresentation(postImage);
	[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].imageView.image = [self processStyle:postImage];
	//[composeView setAttachmentImage:postImage];
    //[composeView setAttachmentImage:image];
    [self performSelectorOnMainThread:@selector(completeCompressingTask) withObject:nil waitUntilDone:YES];
    [pool release];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%i", buttonIndex);
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
        switch (buttonIndex) {
            case 0:  
                [self showImagePicker:YES]; 
                break;
            default: 
                [self showImagePicker:NO]; 
                break;
        }
         
     
}

- (void)takePhotoAction
{ 
	UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:@""
                                                            delegate:self cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:
                                 @"拍摄照片", 
                                 @"选择照片",
                                 nil];
    //UIImage *image=[UIImage imageNamed:@"ButtonTwitter.png"];
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	[styleAlert showInView:self.view];
	[styleAlert release];
}
- (void) completeCompressingTask {
	//[self endCompress];
    //[composeView performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.1];
}

- (UIImage*)processStyle:(UIImage*)_image {
	if (!_image) {
		return _image;
	}
	
	return [[TweetImageStyle sharedStyle] processWithClassName:@"profileImageMiddle"
													  forImage:_image];
}

- (UIImage *)getImageFromStyledImageCache {
	return [[TweetImageStyle sharedStyle] getImageFromCacheByClassName:@"profileImageMiddle"
                                                               withUrl:account.headphoto];
}

- (UIImage*)downloadImage {
	
	if (nil != account && account.headphoto && account.headphoto.length > 0) {
		UIImage *cachedImage = [self getImageFromStyledImageCache];
		if (!cachedImage) {
			cachedImage = [[ImageDownloader downloaderWithName:@"profileImages"] 
						   getImage:account.headphoto delegate:_receiver];
			if (cachedImage) {
				//cachedImage = [self processStyle:cachedImage];
				TweetImageStyle *style = [TweetImageStyle sharedStyle];
				ImageCache *styleCache = [style getStyledImageCache:@"profileImageMiddle"];
				UIImage *styledImage = [styleCache imageForURL:account.headphoto];
				if (styledImage) {
					cachedImage = styledImage;
				}
				else {
					cachedImage = [self processStyle:cachedImage];
					[styleCache storeImage:cachedImage forURL:account.headphoto];
				}
			}
		}
		return cachedImage;
	} 
	return nil;
	
}

- (void)setAccount:(AccountInfo *)value {
	if (account != value) {
		if (account)
			[downloader removeDelegate:_receiver forURL:account.headphoto];
		[account release];
		account = [value retain];
        currentRegion =  [NSString stringWithFormat:@"%@ %@",account.oftenAddressOfProvince,account.oftenAddress];
        currentInfomation = account.descirption;
		[profileImage release];
		profileImage = [[self downloadImage] retain];
        currentOftenAddressId = account.oftenAddressId;
        currentoftenAddressOfProvinceId = account.oftenAddressOfProvinceId;
        
        
		 
	}
}

-(void)loadAcount{

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)actionBack{

    [self dismissModalViewControllerAnimated:YES];
}
-(void)doSaveAction{
    Bean *b =[CommonUtils updateUserInforWith:currentInfomation andSex:[NSString stringWithFormat:@"%d",1+currentSexIndex]  andSprovince:currentoftenAddressOfProvinceId andScity:currentOftenAddressId andHeadImageData:currentHeadImage];
    
    [CommonUtils ShowWaitingView:NO];
    if ([b.err intValue] ==0 ) {
        [self actionBack];
    }else{
        [CommonUtils ShowErroringInView:self.view  WithErrorMessage:b.msg  ];
    }
    
}
-(void)submit{
    [CommonUtils ShowWaitingView:YES];
    [self performSelector:@selector(doSaveAction) withObject:nil afterDelay:0.3];
}

-(void)didSelectIndustryPicker:(NSArray *)_array{
    if (_array) {
        if ([_array count]>1) {
            currentoftenAddressOfProvinceId = [[_array objectAtIndex:0] objectForKey:@"id"];
            currentOftenAddressId = [[_array objectAtIndex:1] objectForKey:@"id"];
            currentRegion = [[NSString stringWithFormat:@"%@ %@",[[_array objectAtIndex:0] objectForKey:@"name"],[[_array objectAtIndex:1] objectForKey:@"name"]]retain];
            NSLog(@"currentRegion = %@",currentRegion);
            NSLog(@"currentoftenAddressOfProvinceId = %@ ,currentOftenAddressId = %@",currentoftenAddressOfProvinceId,currentOftenAddressId);
            [tableView reloadData];
        }else{
            currentoftenAddressOfProvinceId = [[_array objectAtIndex:0] objectForKey:@"id"];
            currentRegion = [NSString stringWithFormat:@"%@ ",[[_array objectAtIndex:0] objectForKey:@"name"]];
             [tableView reloadData];
        }
    }
    NSLog(@"_array = %@",_array);
}

#pragma mark -
#pragma 
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setNeedsDisplay1];
    [self setViewControllerTitle:@"编辑用户资料"];
    [self leftBackBtnWithBackgroupImageName:@"navigationbar_button_background" withTitle:@"取消" andAction:@selector(actionBack)];
    
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background" withTitle:@"保存" andAction:@selector(submit)];
    detailCellFont = [[UIFont systemFontOfSize:17] retain];
    cellFont = [[UIFont systemFontOfSize:15]retain];
   
     
    pickerView = [[IndustryPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    pickerView.industryDelegate=self;
  
}
//-(void)viewDidAppear:(BOOL)animated{
//    //[tableView reloadData];
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     
    return 45.0f;
}
- (void)onCheckSelected:(int) index
{
    NSLog(@"index = %d",index);
    currentSexIndex = index;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
 
    if (section==0) {
        
    
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectZero];
    // myView.backgroundColor =[UIColor redColor];
        UILabel *lab1 =[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 45, 45)];
        boxView = [[[NSBundle mainBundle] loadNibNamed:@"DWCheckBoxView" owner:self options:nil] objectAtIndex:0];
        boxView.frame = CGRectMake(100, 0, boxView.frame.size.width, boxView.frame.size.height);
        [boxView setTitle:@"男" andTitle:@"女"];
        boxView.delegate = self;
        lab1.text = @"性别";
        lab1.font = cellFont;
        [myView addSubview:lab1];
        [myView addSubview:boxView];
        if (account.sex) {
            currentSexIndex =[[account sex] intValue]-1;
            [boxView setDefaultChecked:currentSexIndex];
            
            NSLog(@"currentSexIndex = %d",currentSexIndex);
        } 
        [lab1 release];
      return myView;
    }else{
    
        return nil;
    }

}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 45.0f;
//}

- (UITableViewCell*)userProfileCell:(int)row {
	static NSString *CellIdentifier = @"userProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.font = cellFont;
		cell.detailTextLabel.font = detailCellFont;
		cell.detailTextLabel.numberOfLines = 0;
	} 
    if (row == 0) {
		cell.textLabel.text = @"现居地";
		cell.detailTextLabel.text =currentRegion;// [NSString stringWithFormat:@"%@ %@",account.oftenAddressOfProvince,account.oftenAddress];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
	}
	else if (row == 1) {
		cell.textLabel.text = @"介绍";
		cell.detailTextLabel.text = currentInfomation;//account.descirption;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
	}
	return cell;
}

-(void)UserDidEdite:(NSString*)content{
 
    currentInfomation = [content retain];
    [tableView reloadData];
    
}
#pragma tableview
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 2;
} 
 

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell * cell = [_tableView
                              dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if(cell == nil) {
        
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:SimpleTableIdentifier] autorelease];
      
    }
        UIImage *image = profileImage;
        if (!image) {
            image = defaultProfileImage;
        }
        cell.imageView.image = image;
        cell.imageView.frame =cell.textLabel.frame; //CGRectMake(cell.imageView.frame.origin.x+3, cell.imageView.frame.origin.y, cell.imageView.frame.size.width,cell.imageView.frame.size.height);
        cell.textLabel.font = cellFont;//cellFont;
		//cell.detailTextLabel.font = detailCellFont;
        cell.textLabel.text = @"上传头像";
		//cell.detailTextLabel.text = @"上传头像";
        
    //cell.imageView.image=[NSURL  ] 
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
       return cell;
    }
    else if (indexPath.section == 1) {
			 return [self userProfileCell:indexPath.row];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (  indexPath.section == 1) {
		CGFloat detailLabelWidth = 207;
		CGSize size;
		if (indexPath.row == 0) {
			size = [currentRegion  sizeWithFont:detailCellFont  
                                 constrainedToSize:CGSizeMake(detailLabelWidth, 9999)];
		}
		else if (indexPath.row == 1) {
			size = [currentInfomation sizeWithFont:detailCellFont  
                                           constrainedToSize:CGSizeMake(detailLabelWidth, 9999)];
		} 
		CGFloat height = size.height + 16;
		if (height < 44) {
			height = 44;
		}
		return height;
	}
	
    return 44;
}

-(void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [_tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
            
        if (indexPath.row ==0) {
            [self  takePhotoAction];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row == 0) {
            NSLog(@"currentoftenAddressOfProvinceId= %@ currentOftenAddressId = %@",currentoftenAddressOfProvinceId,currentOftenAddressId);
            
            [pickerView selectToIndustryId:currentoftenAddressOfProvinceId   and:currentOftenAddressId];
             
            [pickerView show];
        }
        if (indexPath.row ==1) {
            detailView.content = currentInfomation;
            detailView.delegate = self; 
            [self.navigationController pushViewController:detailView animated:YES];
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return  NO;
}

@end
