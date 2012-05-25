//
//  TabBarController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CostomTabBarController.h"

@implementation CostomTabBarController

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	NSLog(@"Tab Bar: %d", item.tag);
	int tagid = item.tag;
    
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:.5];
	switch (item.tag) {
        case 0:
            lightImageView.frame = CGRectMake(2, 1, 76, 48);
            break;
        case 1:
            lightImageView.frame = CGRectMake(82, 1, 76, 48);
            break;
        case 3:
            lightImageView.frame = CGRectMake(162, 1, 76, 48);
            break;
        case 4:
            lightImageView.frame = CGRectMake(242, 1, 76, 48);
            break;
            
        default:
            break;
    }
     	
    
}
-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{        
       
    return NO;    
	 }

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(addImageView) withObject:nil afterDelay:0.1];
    
}

-(void)addImageView
{
    UIImageView * tabImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableBar-副本.png"]];
    tabImageView.frame = CGRectMake(0, 0, 320, 49);
    tabImageView.backgroundColor = [UIColor clearColor];
    [self.tabBar addSubview:tabImageView];
    
    lightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderImage.png"]];
    lightImageView.frame = CGRectMake(2, 1, 76, 48);
    [tabImageView addSubview:lightImageView];
    
    UIImageView * DaTingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Native-银联-购彩大厅.png"]];
    
    DaTingImageView.frame = CGRectMake(20, 4, 30, 30);
    [tabImageView addSubview:DaTingImageView];
    [DaTingImageView release];
    
    UILabel * DaTingLabel = [[UILabel alloc] init];
    DaTingLabel.frame = CGRectMake(0, 32, 76, 14);
    DaTingLabel.font = [UIFont systemFontOfSize:11];
    DaTingLabel.backgroundColor = [UIColor clearColor];
    DaTingLabel.textColor = [UIColor whiteColor];
    DaTingLabel.textAlignment = UITextAlignmentCenter;
    [tabImageView addSubview:DaTingLabel];
    
    DaTingLabel.text = @"购彩大厅";
    [DaTingLabel release];
    
    //彩票账户
    
    UIImageView * ZhangHuImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Native-银联-购彩账户.png"]];
    //    ZhangHuImageView.frame = CGRectMake(82, 1, 76, 48);
    ZhangHuImageView.frame = CGRectMake(104, 4, 30, 30);
    [tabImageView addSubview:ZhangHuImageView];
    [ZhangHuImageView release];
    
    UILabel * ZhangHuLabel = [[UILabel alloc] init];
    ZhangHuLabel.frame = CGRectMake(82, 34, 76, 14);
    ZhangHuLabel.font = [UIFont systemFontOfSize:11];
    ZhangHuLabel.backgroundColor = [UIColor clearColor];
    ZhangHuLabel.textColor = [UIColor whiteColor];
    ZhangHuLabel.textAlignment = UITextAlignmentCenter;
    [tabImageView addSubview:ZhangHuLabel];
    ZhangHuLabel.text = @"彩票账户";
    [ZhangHuLabel release];
    
    //开奖公告
    UIImageView * GonggaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Native-银联-彩票公告.png"]];
    //    GonggaoImageView.frame = CGRectMake(162, 1, 76, 48);
    GonggaoImageView.frame = CGRectMake(186, 4, 30, 30);
    
    [tabImageView addSubview:GonggaoImageView];
    [GonggaoImageView release];
    
    UILabel * GonggaoLabel = [[UILabel alloc] init];
    GonggaoLabel.frame = CGRectMake(162, 34, 76, 14);
    GonggaoLabel.font = [UIFont systemFontOfSize:11];
    GonggaoLabel.backgroundColor = [UIColor clearColor];
    GonggaoLabel.textColor = [UIColor whiteColor];
    GonggaoLabel.textAlignment = UITextAlignmentCenter;
    [tabImageView addSubview:GonggaoLabel];
    GonggaoLabel.text = @"开奖公告";
    [GonggaoLabel release];
    
    //购彩帮助
    UIImageView * HelpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Native-银联-购彩帮助.png"]];
    //    HelpImageView.frame = CGRectMake(242, 1, 76, 48);
    HelpImageView.frame = CGRectMake(264, 4, 30, 30);
    [tabImageView addSubview:HelpImageView];
    [HelpImageView release];
    
    UILabel * HelpLabel = [[UILabel alloc] init];
    HelpLabel.frame = CGRectMake(242, 34, 76, 14);
    HelpLabel.font = [UIFont systemFontOfSize:11];
    HelpLabel.backgroundColor = [UIColor clearColor];
    HelpLabel.textColor = [UIColor whiteColor];
    HelpLabel.textAlignment = UITextAlignmentCenter;
    [tabImageView addSubview:HelpLabel];
    HelpLabel.text = @"购彩帮助";
    [HelpLabel release];
}
 

-(void)dealloc
{
    [lightImageView release];
    [super dealloc];
}
@end
