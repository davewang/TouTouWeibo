//
//  LoginUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h"
#import "ASIFormDataRequest.h"
#import "RegistViewController.h" 
@interface LoginUIViewController : BaseUIViewController
{
    
    ASIFormDataRequest *request;
    NSURL *url;
    IBOutlet UITextField *userNameField;
    IBOutlet UITextField *passwordField;
    
    IBOutlet UIButton *signin;
    IBOutlet UIButton *signup;  
}
-( IBAction )login;
@end
