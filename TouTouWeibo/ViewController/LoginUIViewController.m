//
//  LoginUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "LoginUIViewController.h"
#import "CostomNavgationBar.h"
#import "CommonUtils.h" 
#import "CJSONDeserializer.h"
#import "HomeTimeLinesViewController.h" 
#import "Bean.h"
@implementation LoginUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar  setNeedsDisplay1];
 
    [self setViewControllerTitle:@"E头头网" ];
    [signin setBackgroundImage:[CommonUtils stretchableImageFromName:@"login_signinbutton_background.png"] forState:UIControlStateNormal]; 
    
    [signup setBackgroundImage:[CommonUtils stretchableImageFromName:@"login_signupbutton_background.png"] forState:UIControlStateNormal]; 
//    
//    UIImage *img=[UIImage imageNamed:@"login_signupbutton_background.png"];
//    UIImage *imgPressed=[img stretchableImageWithLeftCapWidth:12 topCapHeight:0];
//    [signin setBackgroundImage:imgPressed forState:UIControlStateHighlighted];//按下后出现的图
    
}
#pragma regist
-(IBAction)regist:(id)sender
{
   
    RegistViewController* registViewController = [[RegistViewController alloc] init];
    
    [self.navigationController pushViewController:registViewController animated:YES];
    //    [UIView commitAnimations];
    [registViewController release];
}
#pragma login
-(IBAction)login{
    //BOOL success;
    [userNameField resignFirstResponder];
    
    [passwordField resignFirstResponder];
    url = [[[ NSURL alloc ] initWithString : LOGIN_URL  ] autorelease ];
    request = [[[ ASIFormDataRequest alloc ] initWithURL : url ] autorelease ];
    [request setPostValue:userNameField.text  forKey:@"F_account"];
    [request setPostValue:passwordField.text  forKey:@"F_password"];
    [request setPostValue:@"no"  forKey:@"autoLogin"];

    // 设置 cookie 使用策略：使用（默认）
    [ request setUseCookiePersistence : YES ];
    [ request startSynchronous ];
    NSString * html=[ request responseString ];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];

    if (range. location == NSNotFound ) { // 如果登录成功
         NSLog(@"html->%@",html
               );
        NSString *userId = [dictionary objectForKey:@"uid"];
        
    //    NSString *msg = [dictionary objectForKey:@"msg"];
        
      //  NSString *err = [dictionary objectForKey:@"err"];
        passwordField.text =@"";
        Bean *bean = [Bean BeanWithNSDictionary:dictionary];
        if ([bean.err intValue]==0) {
            [GlobalInfo sharedGlobalInfo].userId = userId;
            
            [[AppDelegate getAppDelegate] signIn];
        }else{
            [CommonUtils ShowErroringInView:self.view WithErrorMessage:bean.msg];
        
        }
      
     //  
        NSLog(@"login success");
    } else { // 如果登录失败 
       // [[AppDelegate getAppDelegate] signIn];
        
        [CommonUtils ShowErroringInView:self.view WithErrorMessage:@"登录失败,原因未知。 "];
        NSLog(@"login success");
    }
    
    // 获得本地 cookies 集合（在第一次请求时服务器已返回 cookies，
    //   虽然其中很可能只有一个cookie: sessionid ）
    NSArray *cookies = [ request responseCookies ];
    // 打印 sessionid
    NSHTTPCookie *cookie = nil ;
    for (cookie in cookies) {
        if ([[cookie name ] isEqualToString : @"JSESSIONID" ]) {
            NSLog ( @"session name:%@,value:%@" ,[cookie name ],[cookie value ]);
        }
    }
    
    
}

-(IBAction)listWeibo{
    //BOOL success;
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBOLIST_URL  ] autorelease ];
    request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:@"0"  forKey:@"type"];
    [request setPostValue:@"1"  forKey:@"pageNo"];
     
    // 设置 cookie 使用策略：使用（默认）
    [ request setUseCookiePersistence : YES ];
    [ request startSynchronous ];
    NSString * html=[ request responseString ];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
     
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    //    id theObject = [[CJSONDeserializer deserializer] deserialize:jsonData error:&error];
    
    
      NSLog(@"dictionary ->%@",dictionary);
    //    NSLog(@"theObject ->%@",theObject);
    //    
    if (range. location == NSNotFound ) { // 如果 成功
        NSLog(@"html->%@",html
              );
        NSLog(@"list success");
    } else { // 如果 失败 
        
        NSLog(@"list success");
    }
      
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
