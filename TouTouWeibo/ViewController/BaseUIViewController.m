//
//  BaseUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-25.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "BaseUIViewController.h"

@implementation BaseUIViewController

-(void)setViewControllerTitle:(NSString *)title{
    
     UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.text = title;
        titleView.textColor = NAV_TITLE_COLOR;
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textAlignment = UITextAlignmentCenter;
        
        
        titleView.font = [UIFont systemFontOfSize:NAV_TITLE_SIZE]; 
        [titleView setHighlighted:YES];
        self.navigationItem.titleView = titleView;
        [titleView release];
    }else{
        titleView.text = title;
    }
    [titleView sizeToFit];
    
}
-(void)setViewControllerTitle:(NSString *)title withNavigationItem:(UINavigationItem*)item{
    
    UILabel *titleView = (UILabel *)item.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.text = title;
        titleView.textColor = NAV_TITLE_COLOR;
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textAlignment = UITextAlignmentCenter;
        
        
        titleView.font = [UIFont systemFontOfSize:NAV_TITLE_SIZE]; 
        [titleView setHighlighted:YES];
        item.titleView = titleView;
        [titleView release];
    }else{
        titleView.text = title;
    }
    [titleView sizeToFit];
    
}
-(void)rightBtnWithImageName:(NSString*)imageName imageHighlightedName:(NSString*)imagehighlightedName andAction:(SEL)_action{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 48, 48);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:imagehighlightedName]  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem=barsubmitButton;
    [barsubmitButton release];
    
}
-(void)leftBackBtnWithBackgroupImageName:(NSString *)imageName withTitle:(NSString*)title andAction:(SEL)_action
{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 30);
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [backBtn setBackgroundImage:[CommonUtils stretchableImageFromName:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=barsubmitButton;
    [barsubmitButton release];
}
-(void)rightBackBtnWithBackgroupImageName:(NSString *)imageName withTitle:(NSString*)title andAction:(SEL)_action
{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 30);
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [backBtn setBackgroundImage:[CommonUtils stretchableImageFromName:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem=barsubmitButton;
    [barsubmitButton release];
}
-(void)leftBackBtnWithBackgroupImageName:(NSString *)imageName withNavigationItem:(UINavigationItem*)_navigationItem1 withTitle:(NSString*)title andAction:(SEL)_action
{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 30);
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [backBtn setBackgroundImage:[CommonUtils stretchableImageFromName:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    _navigationItem1.leftBarButtonItem=barsubmitButton;
    [barsubmitButton release];
}
-(UIBarButtonItem*)leftBtnWithNavigationItem:(UINavigationItem*)_navigationItem1 withTitle:(NSString*)title andAction:(SEL)_action
{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 30);
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [backBtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"navigationbar_button_background.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    _navigationItem1.leftBarButtonItem=barsubmitButton;
  //  [barsubmitButton release];   
    return [barsubmitButton autorelease];
}
-(UIBarButtonItem*)rightBtnWithNavigationItem:(UINavigationItem*)_navigationItem1 withTitle:(NSString*)title andAction:(SEL)_action
{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 30);
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [backBtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"navigationbar_button_background.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    _navigationItem1.rightBarButtonItem=barsubmitButton;
     return [barsubmitButton autorelease];
  //  [barsubmitButton release];
}

-(void)leftBackBtnWithImageName:(NSString*)imageName imageHighlightedName:(NSString*)imagehighlightedName andAction:(SEL)_action{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 48, 48);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:imagehighlightedName]  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=barsubmitButton;
    [barsubmitButton release];
    
}
-(void)leftBackBtnWithAction:(SEL)_action{

    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 48, 48);
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=barsubmitButton;
    [barsubmitButton release];
    
}
-(void)leftBackHomeBtnWithAction:(SEL)_action{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 48, 48);
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_home.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_home_highlighted.png"]  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=barsubmitButton;
    [barsubmitButton release];
    
}
-(void)rightBackHomeBtnWithAction:(SEL)_action{
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 48, 48);
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_home.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_home_highlighted.png"]  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:_action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem=barsubmitButton;
    [barsubmitButton release];
    
}
-(void)actionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
