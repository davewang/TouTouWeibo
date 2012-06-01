//
//  MoreUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MoreUIViewController.h"
#import "DisplayModeSettingUIViewController.h"
#import "CheckBoxView.h"
#import "AboutUIViewControlloer.h"
#define SOUND_ENABLE_TAG  1111   
@implementation MoreUIViewController
@synthesize tableView=_tableView;
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
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"更多"];
    data = [[NSArray alloc] initWithObjects:@"声音",@"修改密码",@"帐号管理",@"浏览模式",@"关于",@"注销", nil];
    
    imageNames = [[NSArray alloc] initWithObjects:@"setting_messages_audio.png",@"settings_accounts_icon.png",@"settings_accounts_icon.png",@"settings_browsemode_icon.png",@"settings_about_icon.png",@"settings_signout_icon.png", nil]; 
    // selectd 0 178 238
   // self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"group_picker_cell_separator.png"]];
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //UITableViewCellSeparatorStyle
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [data count];
} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell * cell = [_tableView
                              dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if(cell == nil) {
        
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:SimpleTableIdentifier] autorelease];
        //cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        //24 116 205
       
        //cell.selectedBackgroundView.backgroundColor =  [UIColor colorWithRed:(float)24/255 green:(float)116/255 blue:(float)205/255 alpha:1];
        
        if (indexPath.row == 0) {
            if (![cell viewWithTag:SOUND_ENABLE_TAG])
            {
                CheckBoxView *btn = [[CheckBoxView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-56, 10, 56 , 56)];
                [cell addSubview: btn];
                [btn release];
            }
        }
    }
    cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
  //  cell.textLabel.textColor= NAV_TITLE_COLOR;
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
     

}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }else{
        [[AppDelegate getAppDelegate] logOut];
    
    }
    
     
    [alertView release];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==1) {
      ChangePasswordUIViewController *changepasswd =  [[ChangePasswordUIViewController alloc ] init];
        
      //  [self.navigationController pushViewController:changepasswd animated:YES];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changepasswd];
        [changepasswd release];
        [self.navigationController presentModalViewController:nav animated:YES];
        [nav release];
    }else if(indexPath.row == 3)
    {
       DisplayModeSettingUIViewController *displayModeView = [[DisplayModeSettingUIViewController alloc ] init ];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:displayModeView animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [displayModeView release];
    }else if(indexPath.row == 4){
        AboutUIViewControlloer *about = [[AboutUIViewControlloer alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [about release];
    
    }else if(indexPath.row == 2){
     
        AccountManagerViewController *changepasswd =  [[AccountManagerViewController alloc ] init];
        
        //  [self.navigationController pushViewController:changepasswd animated:YES];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changepasswd];
        [changepasswd release];
        [self.navigationController presentModalViewController:nav animated:YES];
        [nav release];
    }
    else if(indexPath.row ==5){
    
    
        UIAlertView *arertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要推出吗？"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [arertView show];
        
    }
     
    

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
