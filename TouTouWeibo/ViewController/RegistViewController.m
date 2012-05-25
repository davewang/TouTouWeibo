//
//  RegistViewController.m
//  ChinaPayOnline
//
//  Created by 彭瑶 on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegistViewController.h"  
#import "Style.h" 
@implementation RegistViewController
@synthesize  registTableView;
@synthesize  loginPasswordTextField1, cellNumberTextField,shortMessageTextField,realNameTextField;
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
    self.cellNumberTextField = nil;
    self.shortMessageTextField = nil;
    
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)submit{

}
-(void)checkboxClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
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
    
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background" withTitle:@"保存" andAction:@selector(submitButtonPressed:)];
    
    [super viewDidLoad];
    
    [self setViewControllerTitle:@"注册"];
    //    [registTableView addSubview:infolabel];
    [self leftBackBtnWithAction:@selector(actionBack) ];
    
 

    // Do any additional setup after loading the view from its nib.
//    
//    
//    UIButton *submitButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    submitButton.frame=CGRectMake(0, 0, 72, 32);
//	[submitButton setBackgroundImage:[UIImage imageNamed:@"rightBarButton.png"] forState:UIControlStateNormal];
//	[submitButton setTitle:@"提交注册" forState:UIControlStateNormal];
//	[submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//	UIBarButtonItem * barsubmitButton=[[UIBarButtonItem alloc] initWithCustomView:submitButton];
//    self.navigationItem.rightBarButtonItem=barsubmitButton;
//	[barsubmitButton release];
    
    
    
    cellNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    loginPasswordTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    realNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    shortMessageTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    //shortMessageTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 175, 20)];
    
    currentCheckIndex = 0;
}
 
-(void)actionBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submitButtonPressed:(UIButton *)sender
{
  //  NSString * emailstring = mobileNumberTextField.text;
    
  //  NSString * newEmailStr=[emailstring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if ([newEmailStr length]==0)
//    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入有效的电子邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//        return; 
//    }
//    else
        if([loginPasswordTextField1.text length]==0)
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
    else if ([cellNumberTextField.text length]==0)
    {//检查手机号码
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入有效的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
        
    } 
    else if ([shortMessageTextField.text length]==0) 
    {//检查手机号码
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入短信验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
        
    }else if ([realNameTextField.text length]==0) 
    {//检查手机号码
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入真实姓名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
        
    }
    [CommonUtils ShowWaitingView:YES];
    [realNameTextField resignFirstResponder];
    [cellNumberTextField resignFirstResponder];
    [loginPasswordTextField1 resignFirstResponder];
    [shortMessageTextField resignFirstResponder];
    [self performSelector:@selector(doRegistAction) withObject:nil afterDelay:0.4];
    
     
//    NSMutableArray * registInfoArray = [[NSMutableArray alloc] initWithObjects:@"0",@"100_1000", nil];
//    
//    [registInfoArray addObject:[NSString stringWithFormat:@"%@",mobileNumberTextField.text]];//添加电子邮件信息；
//    [registInfoArray addObject:[NSString stringWithFormat:@"%@",loginPasswordTextField1.text]];//密码
//    [registInfoArray addObject:[NSString stringWithFormat:@"%@",loginPasswordTextField2.text]];//确认密码
//    [registInfoArray addObject:[NSString stringWithFormat:@"%@",cellNumberTextField.text]];//手机号码
//    [registInfoArray addObject:@""];// 附加吗为空；
//    [registInfoArray addObject:[NSString stringWithFormat:@"%@",shortMessageTextField.text]];//短信验证
//    
//    
//     
//    [registInfoArray release];
    
    
}

-(void)receiveString:(NSString * )bb receiveArray:(NSArray *)dd 
{
      
    
}
-(void)receiveCertString:(NSString *)str receiveCertArr:(NSArray *)newArr
{  
    
}
-(void)receiveLoginString:(NSString * )bb receiveLoginArray:(NSArray *)dd
{ 
}

-(IBAction)aswitchchanged:(UISegmentedControl *)asegment
{
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex == buttonIndex) {
        [self actionBack];
    }
}
-(void)doRegistAction{
    
    Bean *bean = [CommonUtils registerUserWithPhone:cellNumberTextField.text withName:realNameTextField.text withPassword:loginPasswordTextField1.text withIcode:shortMessageTextField.text withCitype:currentCheckIndex];
    [CommonUtils ShowWaitingView:NO];
    if ([bean.err intValue]==0 ) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"恭喜您注册成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
    } else{
        [CommonUtils ShowErroringInView:self.view  WithErrorMessage:bean.msg];
        
    }
}
-(void)getCheckNumber{
   
    
   Bean *bean = [CommonUtils getCheckNumber:cellNumberTextField.text];
    [CommonUtils ShowWaitingView:NO];
    if ([bean.err intValue]==0 ) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请查收验证码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
    } else{
        [CommonUtils ShowErroringInView:self.view  WithErrorMessage:bean.msg];
       
    }
}
-(IBAction)getmessageButtonPressed:(UIButton * )sender
{
    
    if (![cellNumberTextField.text isMatchedByRegex:@"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0|2|3|5|6|7|8|9]|14[5|7])[0-9]{8}$"]) 
    {//检查手机号码
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请确定手机号是否输入正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return ;
        
    }
    [CommonUtils ShowWaitingView:YES];
    
    [self performSelector:@selector(getCheckNumber) withObject:nil afterDelay:0.4];
    
    //+(Bean*)getCheckNumber:(NSString *)D_icode
    
//    NSMutableArray * getMessageArray = [[NSMutableArray alloc] initWithObjects:@"0",@"499_1000", nil];
//    [getMessageArray addObject:[NSString stringWithFormat:@"%@",cellNumberTextField.text]];
//    
//    [getMessageArray release];
    
    
}

- (void)onCheckSelected:(int) index{

    currentCheckIndex = index;
    NSLog(@"index = %d",index);
}
-(void)receiveShortMessageString:(NSString * )bb receiveShortMessageArray:(NSArray *)dd
{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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

            alabel.text = @"手机号码";
            alabel.textAlignment = UITextAlignmentRight;
            //            cellNumberTextField = atextField;
            cellNumberTextField.placeholder =@"请输入手机号码";
            cellNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
            cellNumberTextField.font = Style_ContentTextFont;
            cellNumberTextField.textColor = Style_ContentTextColor;
            cellNumberTextField.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:cellNumberTextField];
        }
        else if (1 == row)
        {
 
            alabel.text = @"真实姓名";
            alabel.textAlignment = UITextAlignmentRight; 
            realNameTextField.placeholder = @"输入真实姓名";
          //  [realNameTextField setSecureTextEntry:YES];
            realNameTextField.font = Style_ContentTextFont;
            realNameTextField.textColor = Style_ContentTextColor;
            realNameTextField.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:realNameTextField];
        }
        else if (2 == row)
        {
            alabel.text = @"创建密码";
            alabel.textAlignment = UITextAlignmentRight;
            //            loginPasswordTextField1 = atextField;
            loginPasswordTextField1.placeholder = @"初始密码（6-20位字符或数字）";
            [loginPasswordTextField1 setSecureTextEntry:YES];
            loginPasswordTextField1.font = Style_ContentTextFont;
            loginPasswordTextField1.textColor = Style_ContentTextColor;
            loginPasswordTextField1.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:loginPasswordTextField1];
         }
        else if (3 == row)
        {
 
            alabel.text = @"短信验证码";
            alabel.textAlignment = UITextAlignmentRight;
            //            shortMessageTextField = atextField;
            shortMessageTextField.placeholder = @"请输入短信验证码";
            shortMessageTextField.keyboardType = UIKeyboardTypeNumberPad;
            shortMessageTextField.font = Style_ContentTextFont;
            shortMessageTextField.textColor = Style_ContentTextColor;
            shortMessageTextField.delegate=self;
            [cell.contentView addSubview:alabel];
            [alabel release];
            [cell.contentView addSubview:shortMessageTextField];
            //            [atextField release];
            
            UIButton * getmessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            getmessageButton.frame = CGRectMake(244, 10, 60, 30);
            getmessageButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [getmessageButton setBackgroundImage:[UIImage imageNamed:@"huoqu.png"] forState:UIControlStateNormal];
            [getmessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [getmessageButton setTitle:@"获取" forState:UIControlStateNormal];
            [getmessageButton addTarget:self action:@selector(getmessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:getmessageButton];
            
        }else if(4 == row){
            alabel.text = @"您倾向于";
            alabel.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:alabel];
            [alabel release];
            
            boxView = [[[NSBundle mainBundle] loadNibNamed:@"DWCheckBoxView" owner:self options:nil] objectAtIndex:0];
            boxView.frame = CGRectMake(100, 0, boxView.frame.size.width, boxView.frame.size.height);
            boxView.delegate =self;
            [cell.contentView addSubview:boxView];
             
            
//            UIButton *checkbox1 = [UIButton buttonWithType:UIButtonTypeCustom];
//            CGRect checkboxRect = CGRectMake(135,150,36,36);
//            [checkbox1 setFrame:checkboxRect];
//            [checkbox1 setImage:[UIImage imageNamed:@"radio-nocheck.png"] forState:UIControlStateNormal];
//            [checkbox1 setImage:[UIImage imageNamed:@"radio-check.png"] forState:UIControlStateSelected];
//            [checkbox1 addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
//             
//            [cell addSubview: checkbox1];
//            UIButton *checkbox1 = [UIButton buttonWithType:UIButtonTypeCustom];
//            CGRect checkboxRect = CGRectMake(135,150,36,36);
//            [checkbox1 setFrame:checkboxRect];
//            [checkbox1 setImage:[UIImage imageNamed:@"radio-nocheck.png"] forState:UIControlStateNormal];
//            [checkbox1 setImage:[UIImage imageNamed:@"radio-check.png"] forState:UIControlStateSelected];
//            [checkbox1 addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [cell addSubview: btn2];
//            [btn1 release];
//            [btn2 release];
            
        } else{
            [alabel release];
        }
        UIImageView * cellbackGroundImaveView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 295, 40)];
        cellbackGroundImaveView.image = [UIImage imageNamed:Cell_Picture];
        [cell.contentView insertSubview:cellbackGroundImaveView atIndex:0];
        [cellbackGroundImaveView release];
    }
    
    //    [registTableView setContentSize:CGSizeMake(320, 400)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    curTextField = textField;
    if (textField==cellNumberTextField) {
        [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
    [registTableView setContentOffset:CGPointMake(0, textField.superview.superview.frame.origin.y-30) animated:YES];
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;  
{  
    if ([string isEqualToString:@"\n"])   
    {  
        return YES;  
    }  
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];  
    
    if (loginPasswordTextField1 == textField)   
    {  
        if ([toBeString length] > 20) {  
            textField.text = [toBeString substringToIndex:20];  
            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
            //            [alert show];  
            return NO;  
        }  
    }else if (cellNumberTextField == textField){  
        if ([toBeString length] > 11){  
            textField.text = [toBeString substringToIndex:11];  
            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
            //            [alert show];  
            return NO;  
        }  
    }else if (shortMessageTextField == textField){  
        if ([toBeString length] > 6){  
            textField.text = [toBeString substringToIndex:6];  
            //            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];  
            //            [alert show];  
            return NO;  
        }  
    }
    return YES;  
}  

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"+++++++++++++");
    [registTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [curTextField resignFirstResponder];
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
