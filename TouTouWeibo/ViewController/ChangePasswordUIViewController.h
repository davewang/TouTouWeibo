//
//  ChangePasswordUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-26.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//



@interface ChangePasswordUIViewController : BaseUIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    UITableView * registTableView;
     UITextField * oldLoginPasswordTextField;
    UITextField * loginPasswordTextField1;
    UITextField * loginPasswordTextField2;
    
    
    
}
@property (retain,nonatomic) IBOutlet UITableView * registTableView;
@property (retain,nonatomic)  UITextField * loginPasswordTextField1;
@property (retain,nonatomic)  UITextField * loginPasswordTextField2;
@property (retain,nonatomic)  UITextField * oldLoginPasswordTextField;



@end
