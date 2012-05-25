//
//  BaseUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-25.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NAV_TITLE_COLOR	[UIColor colorWithRed:0.29019608f green:0.38039216f blue:0.48627451f alpha:1.0f]

#define NAV_TITLE_SIZE	18.0f
@interface BaseUIViewController : UIViewController

-(void)setViewControllerTitle:(NSString *)title;

-(void)leftBackHomeBtnWithAction:(SEL)_action;

-(void)leftBackBtnWithAction:(SEL)_action;

-(void)leftBackBtnWithImageName:(NSString*)imageName imageHighlightedName:(NSString*)imagehighlightedName andAction:(SEL)_action;
-(void)rightBtnWithImageName:(NSString*)imageName imageHighlightedName:(NSString*)imagehighlightedName andAction:(SEL)_action;

-(void)leftBackBtnWithBackgroupImageName:(NSString *)imageName withTitle:(NSString*)title andAction:(SEL)_action;

-(void)leftBackBtnWithBackgroupImageName:(NSString *)imageName withNavigationItem:(UINavigationItem*)_navigationItem withTitle:(NSString*)title andAction:(SEL)_action;
-(void)rightBackBtnWithBackgroupImageName:(NSString *)imageName withNavigationItem:(UINavigationItem*)_navigationItem withTitle:(NSString*)title andAction:(SEL)_action;
-(UIBarButtonItem*)rightBtnWithNavigationItem:(UINavigationItem*)_navigationItem withTitle:(NSString*)title andAction:(SEL)_action;
-(UIBarButtonItem*)leftBtnWithNavigationItem:(UINavigationItem*)_navigationItem withTitle:(NSString*)title andAction:(SEL)_action;
-(void)rightBackBtnWithBackgroupImageName:(NSString *)imageName withTitle:(NSString*)title andAction:(SEL)_action;


-(void)setViewControllerTitle:(NSString *)title withNavigationItem:(UINavigationItem*)item;


-(void)rightBackHomeBtnWithAction:(SEL)_action;
@end
