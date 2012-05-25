//
//  RegistViewController.h
//  ChinaPayOnline
//
//  Created by 彭瑶 on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWCheckBoxView.h"
@class RegistProtocolViewController;
//@class KeyBoardTopBar;
@interface RegistViewController : BaseUIViewController <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    UITableView * registTableView; 
    UITextField * loginPasswordTextField1; 
    UITextField * realNameTextField;
    UITextField * cellNumberTextField;
    UITextField * shortMessageTextField;
    UITextField * curTextField;
    DWCheckBoxView *boxView;
    int  currentCheckIndex;
  

}
@property (retain,nonatomic) IBOutlet UITableView * registTableView;
 
@property (retain,nonatomic)  UITextField * loginPasswordTextField1;
 

@property (retain,nonatomic)  UITextField * realNameTextField;
@property (retain,nonatomic)  UITextField * cellNumberTextField;
@property (retain,nonatomic)  UITextField * shortMessageTextField;



@end
