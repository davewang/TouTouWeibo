//
//  DWCheckBoxView.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-19.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "DWCheckBoxView.h"

@implementation DWCheckBoxView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    btn1.selected = YES;
    btn2.selected = NO;
    currentCheckIndex = 0;
    currentCheckBtn = btn1;
}

-(void)setDefaultChecked:(int)index{
    if (index ==0) {
        btn1.selected = YES;
        btn2.selected = NO;
         currentCheckIndex = 0;
        currentCheckBtn = btn1;
        [self layoutSubviews];
    }else{
        btn1.selected = NO;
        btn2.selected = YES;
         currentCheckIndex = 1;
        currentCheckBtn = btn2;
        [self layoutSubviews];
    }
}
-(IBAction)checkClickBtn1:(UIButton*)sender
{
    if (currentCheckBtn == sender) {
        return;
    }else{
        currentCheckBtn= sender;
        
    }
    btn2.selected = sender.selected;
    btn1.selected = !sender.selected;
    
    if (btn1.selected) {
        currentCheckIndex = 0;
        
    }else{
        currentCheckIndex = 1;
    }
    if (delegate) {
        [delegate onCheckSelected:currentCheckIndex];
    }
}

-(IBAction)checkClickBtn2:(UIButton*)sender
{
    if (currentCheckBtn == sender) {
        return;
    }else{
        currentCheckBtn= sender;
    
    }
    btn1.selected = sender.selected;
    btn2.selected = !sender.selected;
    if (btn2.selected) {
        currentCheckIndex = 1;
    }else{
        currentCheckIndex = 0;
    }
    if (delegate) {
        [delegate onCheckSelected:currentCheckIndex];
    }
}

-(void)setTitle:(NSString*)title0 andTitle:(NSString*)title1
{
    lab1.text = title0;
    lab2.text = title1;

} 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
