//
//  FriendsDetailViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-10.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FriendsDetailViewController.h"
#define NO_QUANXIAN @"您暂无权限查看TA的信息！"
@implementation FriendsDetailViewController

@synthesize  friendObject;
@synthesize detailTableView;
@synthesize  _findFriendsVCList;
@synthesize  rowTitleList;
@synthesize friendId;

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
    [friendObject release];
    [detailTableView release];
}

-(void)QmeBtnPressed
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Hi,靓仔你好!能交个朋友吗?"
                                                 message:@"谢谢!" 
                                                delegate:self 
                                       cancelButtonTitle:@"发送"
                                       otherButtonTitles:@"取消", nil];
    [alert show];
    [alert release];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"个人名片"];
    [self leftBackBtnWithAction:@selector(actionBack)];
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,70)];
//	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,10,57,57)];
//	imageView.image=[UIImage imageNamed:@"icon.png"];
//	[headerView addSubview:imageView];
//    
//    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(90,8,60,30)];
//    nameLabel.font=[UIFont systemFontOfSize:18];
//    nameLabel.backgroundColor=[UIColor clearColor];
//    nameLabel.text=friendObject.userName;
//    [headerView addSubview:nameLabel];
//    
//    UIImageView *seximageView = [[UIImageView alloc] initWithFrame:CGRectMake(150,14,16,16)];
//	seximageView.image=[UIImage imageNamed:@"profile_genderM.png"];
//	[headerView addSubview:seximageView];
//	self.detailTableView.tableHeaderView = headerView;
//	[imageView release];
//    [nameLabel release];
//    [seximageView release];
//	[headerView release];
 
    UIView *tfooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, detailTableView.frame.size.width, 58)];  
    tfooterView.autoresizingMask = UIViewAutoresizingFlexibleWidth; 
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(130,2,80, 50)];  
    [button setTitle:@"打招呼" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [button addTarget:self action:@selector(QmeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [tfooterView addSubview:button]; 
    self.detailTableView.tableFooterView = tfooterView;  
   // [button release];
    
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"地区",@"班级",@"职位",@"QQ",@"MSN",@"手机号",@"个人简介",@"公司名称",@"公司地址",@"公司电话",nil];
    self.rowTitleList=array;
    [array release];
    detailCellFont = [[UIFont systemFontOfSize:17] retain];
    cellFont = [[UIFont systemFontOfSize:15]retain];
    [CommonUtils ShowWaitingView:YES];
    [self performSelector:@selector(loadFriend)  withObject:nil afterDelay:0.3];
    userProfileHeaderView = [[UserProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.detailTableView.frame.size.width, 72)];
}

-(void)loadFriend{
    self.friendObject =  [CommonUtils loadFriendObjectWithUserId:friendId];
    
    NSLog(@"friendObject --%@",friendObject);
    user = [AccountInfo AccountWithFriendObject:friendObject];
    userProfileHeaderView.user = user;
    [userProfileHeaderView setNeedsDisplay];
    [CommonUtils ShowWaitingView:NO];
    [detailTableView reloadData];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
} 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (user &&  section == 0) {
        return userProfileHeaderView;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (user  && section == 0) {
        return userProfileHeaderView.frame.size.height;
    }
    else {
        return 0;
    }
}

-(void)config{

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"userProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = cellFont;
        cell.detailTextLabel.font = detailCellFont;
        cell.detailTextLabel.numberOfLines = 0;
    } 
//    if (row == 0) {
//        cell.textLabel.text = @"现居地";
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",user.oftenAddressOfProvince,user.oftenAddress];
//    }
//    else if (row == 1) {
//        cell.textLabel.text = @"手机";
//        cell.detailTextLabel.text = user.phone;
//    }
     cell.textLabel.text = [rowTitleList objectAtIndex:indexPath.row];
    
    
    
        
    
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = friendObject.userCity&&![friendObject.userCity isEqualToString:@""]? friendObject.userCity:@"暂无数据";
            break;
        case 1:
            cell.detailTextLabel.text=friendObject.className&&![friendObject.className isEqualToString:@""]? friendObject.className:@"暂无数据";
            
            break;
        case 2:
            cell.detailTextLabel.text=friendObject.workName&&![friendObject.workName isEqualToString:@""]? friendObject.workName:@"暂无数据";
            
            break;
        case 3:
            cell.detailTextLabel.text=friendObject.qqNo&&![friendObject.qqNo isEqualToString:@""]? friendObject.qqNo:@"暂无数据";
            break;
        case 4:
            cell.detailTextLabel.text=friendObject.msnNo&&![friendObject.msnNo isEqualToString:@""]? friendObject.msnNo:@"暂无数据";
            break;
        case 5:
            cell.detailTextLabel.text=friendObject.phone&&![friendObject.phone isEqualToString:@""]? friendObject.phone:@"暂无数据";
            break;
        case 6:
            cell.detailTextLabel.text=friendObject.introduction&&![friendObject.introduction isEqualToString:@""]? friendObject.introduction:@"暂无数据";
            break;
        case 7:
            cell.detailTextLabel.text=friendObject.companyName&&![friendObject.companyName isEqualToString:@""]? friendObject.companyName:@"暂无数据";
            
            break;
        case 8:
            cell.detailTextLabel.text=friendObject.companyAddress&&![friendObject.companyAddress isEqualToString:@""]? friendObject.companyAddress:@"暂无数据";
            break;
        case 9:
            cell.detailTextLabel.text=friendObject.companyTel&&![friendObject.companyTel isEqualToString:@""]? friendObject.companyTel:@"暂无数据";
        default:
            break;
    }

    if ( friendObject &&[[friendObject.personalBaseInformation description] isEqualToString:@"0"]) {
        if (indexPath.row ==0||indexPath.row ==6) {
            cell.detailTextLabel.text = NO_QUANXIAN;
        }
    }
    
    if(friendObject && [[friendObject.contactConfig description] isEqualToString:@"0"])
    {
        if (indexPath.row ==3||indexPath.row ==4||indexPath.row ==5) {
            cell.detailTextLabel.text = NO_QUANXIAN;
        }
    
    }else if(friendObject && indexPath.row ==5)
    {
        if (!friendObject.isFriend) {
             cell.detailTextLabel.text = @"是好友才可见";
        } 
    }
    
    if ([[friendObject.workConfig description] isEqualToString:@"0"]) {
        
        if (indexPath.row==7||indexPath.row==8||indexPath.row==9) {
              cell.detailTextLabel.text = NO_QUANXIAN;
        }
    }
    
    
//    if (ucb.getPersonalBaseInformation().equals("0")) {
//        // 地区 性别 个人描述
//        diquTv.setText(R.string.no_quanxian);
//        disTv.setText(R.string.no_quanxian);
//        sex.setVisibility(View.GONE);
//    } else {
//        if (ucb.getSex().equals("1")) {
//            sex.setImageResource(R.drawable.icon_male);
//        } else {
//            sex.setImageResource(R.drawable.icon_female);
//        }
//        diquTv.setText(ucb.getArea());
//        disTv.setText(ucb.getIntro());
//    }
//    
//    banjiTv.setText(ucb.getBanji());
//    zhiwuTv.setText(ucb.getPost());
//    
//    if (ucb.getContactConfig().equals("0")) {
//        qqTv.setText(R.string.no_quanxian);
//        msnTv.setText(R.string.no_quanxian);
//        
//        contactTv.setText(R.string.no_quanxian);
//    } else {
//        qqTv.setText(ucb.getQq());
//        msnTv.setText(ucb.getMsn());
//        if (ucb.isFriend())
//            contactTv.setText(ucb.getTelphone());
//        else
//            contactTv.setText("是好友才可见");
//    }
    
//    if (ucb.getCompanyAddr().equals(""))
//        addressFlag = false;
//    else
//        addressFlag = true;
//    
//    if (ucb.getWorkConfig().equals("0")) {
//        companyNameTv.setText(R.string.no_quanxian);
//        companyAddressTv.setText(R.string.no_quanxian);
//        companyContactTv.setText(R.string.no_quanxian);
//    } else {
//        companyNameTv.setText(ucb.getCompanyName());
//        // ucb.setCompanyAddr("北京市海淀区上地十街10号百度大厦");
//        
//        companyAddressTv.setText(ucb.getCompanyAddr());
//        companyContactTv.setText(ucb.getCompanyCall());
//    }
    
//    name.setText(ucb.getUserName());
//    if (!ucb.getRemark().equals("")) {
//        markTv.setText("(" + ucb.getRemark() + ")");
//    } else {
//        markTv.setText("");
//    }
//    

//        UILabel *rowTieleLabel=[[UILabel alloc] initWithFrame:CGRectMake(24,2,70,40)];
//        rowTieleLabel.font=[UIFont systemFontOfSize:15];
//        rowTieleLabel.backgroundColor=[UIColor clearColor];
//        
//        rowConttentLabel=[[UILabel alloc] initWithFrame:CGRectMake(100,2,180,40)];    
//        rowConttentLabel.font=[UIFont systemFontOfSize:15];
//        rowConttentLabel.backgroundColor=[UIColor clearColor];
//        
//        rowTieleLabel.text=[self.rowTitleList objectAtIndex:indexPath.row];
//        [cell addSubview:rowTieleLabel];
//        [cell addSubview:rowConttentLabel];
//        [rowTieleLabel release]; 
//        [rowConttentLabel release];
    
    
    
       
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}
@end
