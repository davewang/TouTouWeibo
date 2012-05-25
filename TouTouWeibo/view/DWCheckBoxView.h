//
//  DWCheckBoxView.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-19.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h> 
@protocol DWCheckBoxViewDelegate

- (void)onCheckSelected:(int) index;

@end

@interface DWCheckBoxView : UIView
{
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UILabel *lab1;
    IBOutlet UILabel *lab2;
    UIButton *currentCheckBtn;
    int currentCheckIndex;
    id delegate;
}
@property(nonatomic,assign)id delegate;
-(IBAction)checkClickBtn1:(id)sender;

-(IBAction)checkClickBtn2:(id)sender;
-(void)setDefaultChecked:(int)index; 

-(void)setTitle:(NSString*)title0 andTitle:(NSString*)title1; 
@end
