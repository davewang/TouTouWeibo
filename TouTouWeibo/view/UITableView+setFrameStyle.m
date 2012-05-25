//
//  UITableView+setFrameStyle.m
//  ChinaPayOnline
//
//  Created by 彭瑶 on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UITableView+setFrameStyle.h"
#import <QuartzCore/QuartzCore.h>
 
@implementation UITableView (setFrameStyle)

-(void)reSetFrameStyleInRect:(CGRect)rect WithSeparatorCounts:(int)count AndCellHeight:(CGFloat)height
{
//    UIView * aview = [self viewWithTag:789];
//    if (aview) {
//        
//        [aview removeFromSuperview];
//        for(UIView * subView in self.subviews)
//        {
//            if (subView.tag == 999) {
//                [subView removeFromSuperview];
//            }
//        }
//    }
//    
//    //    UIView * layerview = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, (count+1)*height+rect.origin.y-1)];
//    UIView * layerview = [[UIView alloc] init];
//    
//    if (CGRectEqualToRect(rect,CGRectZero)) 
//    {
//        layerview.frame = CGRectMake(6, 8, 308, (count+1)*height+7);
//        for (int i = 0; i<count; i++) 
//        {
//            UIImageView * separatorView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8+height*(i+1), 300, 5)];
//            separatorView.image = [UIImage imageNamed:@"separatorline.png"];
//            separatorView.tag = 999;
//            [self addSubview:separatorView];
//            [separatorView release];
//            
//        }
//    }
//    else
//    {
//        layerview.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, (count+1)*height+7);
//        for (int i = 0; i<count; i++) 
//        {
//            UIImageView * separatorView = [[UIImageView alloc] initWithFrame:CGRectMake(10, rect.origin.y+height*(i+1), 300, 5)];
//            separatorView.image = [UIImage imageNamed:@"separatorline.png"];
//            separatorView.tag = 999;
//            [self addSubview:separatorView];
//            [separatorView release];
//            
//        }
//    }
//    
//    layerview.userInteractionEnabled = NO;
//    layerview.layer.cornerRadius = 13;
//    layerview.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244/255.0  blue:244/255.0  alpha:1];
//    layerview.layer.shadowColor = [UIColor blackColor].CGColor;
//    layerview.layer.shadowOpacity = 3;
//    layerview.layer.borderWidth = 3;
//    layerview.layer.borderColor = [UIColor blackColor].CGColor;
//    layerview.alpha = 0.05;
//    layerview.tag = 789;
//    
//    
//    
//    [self addSubview:layerview];
//
//    if(!self.backgroundView)
//    {
//        UIImageView * backGroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGround.jpg"]];
//        [backGroundView setContentMode:UIViewContentModeScaleToFill];
//        backGroundView.frame = self.bounds;
//        self.backgroundView = backGroundView;
//        [backGroundView release];
//    }
//    
//

}

-(void)reSetBackGroundImage
{
    UIImage *aimage=[UIImage imageNamed:@"backGround.jpg"];
//    [aimage.CGImage ]
    
    UIImage *bimage=[UIImage imageWithCGImage:CGImageCreateWithImageInRect(aimage.CGImage,
                                                                           self.bounds)];
    UIImageView * backGroundView = [[UIImageView alloc] initWithImage: bimage  ];
     
   backGroundView.frame = CGRectMake(0, 0, 320, 460);
    [backGroundView setContentMode:UIViewContentModeScaleToFill];
    self.backgroundView = backGroundView;
        NSLog(@"self%@",NSStringFromCGRect(self.backgroundView.frame));
    NSLog(@"self%@",NSStringFromCGSize(bimage.size));

    [backGroundView release];
    
}


- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
//    CTextFieldView
    UITouch * touch = [touches anyObject];
    if ([NSStringFromClass([touch.view class])isEqualToString:@"UITextField"]||[NSStringFromClass([touch.view class])isEqualToString:@"UITextView"]||[NSStringFromClass([touch.view class])isEqualToString:@"12"]) {
        NSLog(@"UITextField adsf");
        if ([NSStringFromClass([touch.view class])isEqualToString:@"CTextFieldView"]) {
            UITextField * textfield = [[UITextField alloc] init];
            [self addSubview:textfield];
            [textfield becomeFirstResponder];
            [textfield resignFirstResponder];
            [textfield release];
        }
        return YES;
    }

    UITextField * textfield = [[UITextField alloc] init];
    [self addSubview:textfield];
    [textfield becomeFirstResponder];
    [textfield resignFirstResponder];
    [textfield release];

    if (self.contentSize.height-self.contentOffset.y<self.frame.size.height) 
    {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
        
        if (![NSStringFromCGPoint(self.contentOffset) isEqualToString:NSStringFromCGPoint(CGPointZero)]) {
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    
    

    
    NSLog(@"%@",NSStringFromCGPoint(self.contentOffset));
    
    return YES;
}

@end
