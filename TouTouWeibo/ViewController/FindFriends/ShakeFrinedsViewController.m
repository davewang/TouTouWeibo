//
//  ShakeFrinedsViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ShakeFrinedsViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShakeFrinedsViewController
@synthesize drawer;
@synthesize upView,downView,shakeView,failLabel,activityView;
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

-(void)dealloc
{
    [drawer release];
    [upView release];
    [downView release];
    [shakeView release];
    [failLabel release];
    [activityView release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"摇一摇"];   
    [self leftBackBtnWithAction:@selector(actionBack)];   
    UITableView *_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    drawer = [[DrawerView alloc] initWithView:_tableView parentView:self.view];
    [self.view addSubview:drawer];
    
    
    UIButton * setBt = [UIButton buttonWithType:UIButtonTypeCustom];
    setBt.frame=CGRectMake(0, 0, 40, 30);
    [setBt setTitle:@"设置" forState:UIControlStateNormal];
    [setBt addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:setBt];
    
    //控制导航的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavFrame:) name:@"KHIDENAV" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavFrame:) name:@"KSHOWNAV" object:nil];
    
    AccelerometerHelper * accelerometer = [AccelerometerHelper sharedInstance];
    accelerometer.delegate=self;
    
    shakeView.hidden=YES;
    failLabel.hidden=YES;
}
-(void)set
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要清空历史记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }else{
        //清空请求
    }
}
-(void)changeNavFrame:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"KHIDENAV"]) {
        self.navigationController.navigationBarHidden=NO;
        
    }else if([notification.name isEqualToString:@"KSHOWNAV"]){
       self.navigationController.navigationBarHidden=YES; 
    }
}
-(void)shake
{
    [UIView beginAnimations:@"shake" context:NULL];
    [UIView setAnimationDuration:1];
    upView.frame=CGRectMake(0, -70, 320, 146);
    downView.frame=CGRectMake(0, 146+70, 320, 270);
    [UIView commitAnimations];
    [self performSelector:@selector(shakePhone) withObject:nil afterDelay:1];
}
-(void)shakePhone
{
    [UIView beginAnimations:@"shake" context:NULL];
    [UIView setAnimationDuration:1];
    upView.frame=CGRectMake(0, 0, 320, 146);
    downView.frame=CGRectMake(0, 146, 320, 270);
    [UIView commitAnimations];
    shakeView.hidden=NO;
    [activityView startAnimating];
    
    //发请求 获取数据
    
    
    
    //显示tableview
    [drawer shakeFinished];
    
    
    
}




-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton * customeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    customeBt.backgroundColor=[UIColor redColor];
    customeBt.frame=CGRectMake(0, 0, 320, 50);
    [customeBt setTitle:@"显示早前摇到的人" forState:UIControlStateNormal];
    [customeBt addTarget:self action:@selector(addPerson) forControlEvents:UIControlStateNormal];
    return customeBt;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        [cell.imageView removeFromSuperview];
        [cell.textLabel removeFromSuperview];
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 4, 42, 42)];
        image.backgroundColor=[UIColor redColor];
        [cell.contentView addSubview:image];
        [image release];
//        
//        UILabel * nameLabel = [[UILabel alloc] initWithFrame:<#(CGRect)#>]
        
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
