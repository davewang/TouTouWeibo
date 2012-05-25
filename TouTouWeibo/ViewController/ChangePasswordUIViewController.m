//
//  ChangePasswordUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-26.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ChangePasswordUIViewController.h"
#import "Style.h" 
#import "Bean.h"
@implementation ChangePasswordUIViewController
@synthesize  registTableView;
@synthesize  loginPasswordTextField1, loginPasswordTextField2,oldLoginPasswordTextField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.registTableView = nil; 
    self.loginPasswordTextField1 = nil; 
    self.oldLoginPasswordTextField = nil;
    self.loginPasswordTextField2 = nil;
    
    
    [super dealloc];
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
    
    registTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    registTableView.delegate = self;
    registTableView.dataSource = self;
    registTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:registTableView];
    
    
    [registTableView reSetFrameStyleInRect:CGRectMake(6, 8, 308, 183) WithSeparatorCounts:5 AndCellHeight:Style_TableViewCellHeight];
    
    [super viewDidLoad];
    
    [self setViewControllerTitle:@"修改密码"];
    //    [registTableView addSubview:infolabel];
  //  [self leftBackBtnWithAction:@selector(actionBack) ];
    [self leftBackBtnWithBackgroupImageName:@"navigationbar_button_background.png"  withTitle:@"取消" andAction:@selector(actionBack)];
    
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background.png"  withTitle:@"保存" andAction:@selector(submitButtonPressed:)];
   // [self leftBackBtnWithImageName:@"navigationbar_button_background.png" imageHighlightedName:@"navigationbar_button_background.png" andAction:@selector(actionBack)];
    oldLoginPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    loginPasswordTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    loginPasswordTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
   
    
    
}

-(void)actionBack{
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

-(IBAction)submitButtonPressed:(UIButton *)sender
{
    
    if([loginPasswordTextField1.text length]==0 ||[loginPasswordTextField2.text length]==0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"登录密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else if ([loginPasswordTextField1.text length]<6||[loginPasswordTextField1.text length]>20)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"登录密码必须为6-20位字符或数字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
        
    }  
    [loginPasswordTextField1 resignFirstResponder];
    
    [loginPasswordTextField2 resignFirstResponder];
    
    [oldLoginPasswordTextField resignFirstResponder];
    Bean *b = [CommonUtils updatePasswordWithOldPassword:oldLoginPasswordTextField.text andNewPassword: loginPasswordTextField1.text andCheckPassword:loginPasswordTextField2.text];
    if ([b.err intValue] ==0 ) {
        [self actionBack];
    }else{
         [CommonUtils ShowErroringInView:self.view  WithErrorMessage:b.msg  ];
    }
  
}
 
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    static NSString * cellindentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindentifier] autorelease];
        UILabel * alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 90, 20)];
        alabel.backgroundColor = [UIColor clearColor];
        
        
        alabel.font = Style_LabelTextFont;
        alabel.textColor = Style_LabelTextColor;
        
        
        if (0 == row) {
            
            alabel.text = @"旧密码";
            alabel.textAlignment = UITextAlignmentRight;
            //            cellNumberTextField = atextField;
            oldLoginPasswordTextField.placeholder =@"请输入旧密码";
           // oldLoginPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
              [oldLoginPasswordTextField setSecureTextEntry:YES];
            oldLoginPasswordTextField.font = Style_ContentTextFont;
            oldLoginPasswordTextField.textColor = Style_ContentTextColor;
            oldLoginPasswordTextField.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:oldLoginPasswordTextField];
        }
        else if (1 == row)
        {
            
            alabel.text = @"新密码";
            alabel.textAlignment = UITextAlignmentRight; 
            loginPasswordTextField1.placeholder = @"输入新密码";
            [loginPasswordTextField1 setSecureTextEntry:YES];
            loginPasswordTextField1.font = Style_ContentTextFont;
            loginPasswordTextField1.textColor = Style_ContentTextColor;
            loginPasswordTextField1.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:loginPasswordTextField1];
        }
        else if (2 == row)
        {
            alabel.text = @"确认密码";
            alabel.textAlignment = UITextAlignmentRight;
            loginPasswordTextField2.placeholder = @"输入确认密码";
            [loginPasswordTextField2 setSecureTextEntry:YES];
            loginPasswordTextField2.font = Style_ContentTextFont;
            loginPasswordTextField2.textColor = Style_ContentTextColor;
            loginPasswordTextField2.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:loginPasswordTextField2];
        }
//        else if (3 == row)
//        {
//            
//           
//            
//            
//            
//            
//            UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            saveBtn.frame = CGRectMake(110, 10, 100, 30);
//            saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//            [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//            [saveBtn addTarget:self action:@selector(savePasswordChange:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:saveBtn];
//            [saveBtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"login_signinbutton_background.png"] forState:UIControlStateNormal]; 
//           
//        } 
        else{
            [alabel release];
        }
        if (row!=3) {
            UIImageView * cellbackGroundImaveView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 295, 40)];
            cellbackGroundImaveView.image = [UIImage imageNamed:Cell_Picture];
            [cell.contentView insertSubview:cellbackGroundImaveView atIndex:0];
            [cellbackGroundImaveView release];
        }
    
    }
    
    //    [registTableView setContentSize:CGSizeMake(320, 400)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)savePasswordChange:(id)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    
//    curTextField = textField;
//    if (textField==cellNumberTextField) {
//        [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }else {
//        [registTableView setContentOffset:CGPointMake(0, textField.superview.superview.frame.origin.y-30) animated:YES];
//    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;  
{  
    if ([string isEqualToString:@"\n"])   
    {  
        return YES;  
    }  
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];  
    
//    if (loginPasswordTextField1 == textField)   
//    {  
//        if ([toBeString length] > 20) {  
//            textField.text = [toBeString substringToIndex:20];  
//            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
//            //            [alert show];  
//            return NO;  
//        }  
//    }else if (cellNumberTextField == textField){  
//        if ([toBeString length] > 11){  
//            textField.text = [toBeString substringToIndex:11];  
//            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
//            //            [alert show];  
//            return NO;  
//        }  
//    }else if (shortMessageTextField == textField){  
//        if ([toBeString length] > 6){  
//            textField.text = [toBeString substringToIndex:6];  
//            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
//            //            [alert show];  
//            return NO;  
//        }  
//    }
    return YES;  
}  

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"+++++++++++++");
    [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
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

