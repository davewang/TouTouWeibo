//
//  DWUITabBarController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-30.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DWUITabBarController.h"
#import "UserProfileViewController.h"
#import "GlobalInfo.h"
#define VTabBarHight 49
@implementation DWUITabBarController 


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

-(void)awakeFromNib{

    self.delegate = self;
}
- (void)didReceiveMemoryWarning
{ 
    [super didReceiveMemoryWarning]; 
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self performSelector:@selector(addImageView) withObject:nil afterDelay:0.03];
    
    
}
-(void)doSelectedIndex:(NSUInteger ) _index
{
    
    
	switch (_index) {
            
        case 0:
            [itme1 setHighlighted:YES]; 
            [itme2 setHighlighted:NO];
            [itme3 setHighlighted:NO];
            [itme4 setHighlighted:NO];
            [itme5 setHighlighted:NO];
            [itme6 setHighlighted:NO];
            break;
        case 1:
            [itme1 setHighlighted:NO]; 
            [itme2 setHighlighted:YES];
            [itme3 setHighlighted:NO];
            [itme4 setHighlighted:NO];
            [itme5 setHighlighted:NO];
            [itme6 setHighlighted:NO];
            break;
        case 2:
            [itme1 setHighlighted:NO]; 
            [itme2 setHighlighted:NO];
            [itme3 setHighlighted:YES];
            [itme4 setHighlighted:NO];
            [itme5 setHighlighted:NO];
            [itme6 setHighlighted:NO];
            break;
        case 3:
            
            [itme1 setHighlighted:NO]; 
            [itme2 setHighlighted:NO];
            [itme3 setHighlighted:NO];
            [itme4 setHighlighted:YES];
            [itme5 setHighlighted:NO];
            [itme6 setHighlighted:NO];
            break;
        case 4:
            [itme1 setHighlighted:NO]; 
            [itme2 setHighlighted:NO];
            [itme3 setHighlighted:NO];
            [itme4 setHighlighted:NO];
            [itme5 setHighlighted:YES];
            [itme6 setHighlighted:NO];
            break;  
        case 5:
            [itme1 setHighlighted:NO]; 
            [itme2 setHighlighted:NO];
            [itme3 setHighlighted:NO];
            [itme4 setHighlighted:NO];
            [itme5 setHighlighted:NO];
            [itme6 setHighlighted:YES];
            break; 
        default:
            break;
    }
} 


-(void)reloadFriendsTimeLine{
//    [friendsTimeline viewDidUnload];
  //  [friendsTimeline viewDidLoad];
    [friendsTimeline showWait:YES];
    
}

-(void)reloadFriendsAboutWithMe{
   // [friendsAboutWithMe viewDidUnload];
    
    //[friendsAboutWithMe viewDidLoad];
     [friendsAboutWithMe showWait:YES];

}

-(void)reloaduserProfile{
   // [friendsAboutWithMe viewDidUnload];
   // [friendsAboutWithMe viewDidLoad];
   // if (!userProfile.user) {  
        [userProfile loadUser:[CommonUtils loadAccountByUId:[GlobalInfo  sharedGlobalInfo].userId ]];
        
   // }
    

}
 
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
     
//    if ([viewController isKindOfClass:[UserProfileViewController class]]) {
//        [(UserProfileViewController*)viewController loadUser:[CommonUtils loadAccountByUId:[GlobalInfo sharedGlobalInfo].userId]];
//    }
   // [UIView beginAnimations:nil context:nil];
   // [UIView setAnimationDuration:.2];
//    
    float widthLbl=(320/6);
    
     lightImageView.frame = CGRectMake(widthLbl*tabBarController.selectedIndex,0, widthLbl, VTabBarHight);
   // [UIView commitAnimations];
    [self doSelectedIndex:tabBarController.selectedIndex];
    if (tabBarController.selectedIndex ==2) {
        if (!userProfile.user) {
            [userProfile loadUser:[CommonUtils loadAccountByUId:[GlobalInfo  sharedGlobalInfo].userId ]];

        }
    }
     
    
}

-(void)addImageView
{
    float  lblWidth=(320/6);
   
    UIImageView * tabImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footbg.png"]];
    tabImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    tabImageView.frame = CGRectMake(0, 0, 320, VTabBarHight);
    [self.tabBar addSubview:tabImageView];
    [tabImageView release];
     
    lightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_slider.png"]];
    lightImageView.frame = CGRectMake(lblWidth*0, 0,lblWidth, VTabBarHight);
    [tabImageView addSubview:lightImageView];
    int leftspace = 10;
    
    NSString *imageName = @"tabbar_home.png";
    NSString *imageSelectedName = @"tabbar_home_selected.png";
  
    itme1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    itme1.frame = CGRectMake(leftspace, 4, itme1.image.size.width, itme1.image.size.height);
    
    [tabImageView addSubview:itme1];
     [itme1 setHighlighted:YES]; 
    
    imageName = @"tabbar_message_center.png";
    imageSelectedName = @"tabbar_message_center_selected.png";
    

    
    itme2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    
    itme2.frame = CGRectMake(leftspace+lblWidth, 4, itme2.image.size.width, itme2.image.size.height);
    
    [tabImageView addSubview:itme2];
    
    
    imageName = @"tabbar_profile.png";
    imageSelectedName = @"tabbar_profile_selected.png";
    
    
    itme3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    itme3.frame = CGRectMake(leftspace+lblWidth*2, 4, itme3.image.size.width, itme3.image.size.height);
    
    [tabImageView addSubview:itme3];
    
    
    imageName = @"tabbar_profile.png";
    imageSelectedName = @"tabbar_profile_selected.png";
    
    
    itme4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    itme4.frame = CGRectMake(leftspace+lblWidth*3, 4, itme4.image.size.width, itme4.image.size.height);
    
    [tabImageView addSubview:itme4];
    imageName = @"tabbar_profile.png";
    imageSelectedName = @"tabbar_profile_selected.png";
    
    
    itme5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    itme5.frame = CGRectMake(leftspace+lblWidth*4, 4, itme5.image.size.width, itme5.image.size.height);
    
    [tabImageView addSubview:itme5];
    
    
    imageName = @"tabbar_more.png";
    imageSelectedName = @"tabbar_more_selected.png";
    
    itme6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage: [UIImage imageNamed:imageSelectedName]]; 
    itme6.frame = CGRectMake(leftspace+lblWidth*5, 4, itme6.image.size.width, itme6.image.size.height);
    
    [tabImageView addSubview:itme6];
    NSArray * nameArr=[NSArray arrayWithObjects:@"首页",@"信息",@"我的资料",@"通讯录",@"找朋友",@"更多", nil];
    CGRect rect=CGRectMake(0, 31, lblWidth, 14);
    for (int i=0;i<[nameArr count];i++)
    {
        rect.origin.x=(float)lblWidth*i-2;
        UILabel * nameLbl=[[UILabel alloc] initWithFrame:rect];
        nameLbl.text=[nameArr objectAtIndex:i];
        nameLbl.font = [UIFont systemFontOfSize:11];
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.textColor = [UIColor whiteColor];
        nameLbl.textAlignment=UITextAlignmentCenter;
        [tabImageView addSubview:nameLbl];
        [nameLbl release];
    }
    
} 

 
-(void)dealloc
{
    [lightImageView release];
    [itme1 release];
    [itme2 release];
    [itme3 release];
    [itme4 release];
    [itme5 release];
    [itme6 release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}
@end