//
//  CostomNavgationBar.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-2-28.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CostomNavgationBar.h"

@implementation UINavigationBar(CustomImage)


- (void)drawRect:(CGRect)rect {  
    
    UIImage *image = [UIImage imageNamed: @"navigationbar_background.png"];  
    
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];  
//    UILabel *alabel=[[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
//    alabel.textColor=[UIColor blackColor];
//    alabel.font=[UIFont systemFontOfSize:19];
//    alabel.backgroundColor=[UIColor clearColor];
//    alabel.textAlignment=UITextAlignmentCenter;
//    alabel.text=self.topItem.title;
//    self.topItem.titleView=alabel;
    //	self.tintColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
} 
-(void) setNeedsDisplay1
{
    if([[[UIDevice currentDevice] systemVersion] intValue]<5.0){
        
        [self setNeedsDisplay];
        
    }
    else
    {
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
        
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19], UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,nil];
        self.titleTextAttributes=dic;
        
    }
    
}
 

//-(void) setNeedsDisplayCustomImage
//{
//    if([[[UIDevice currentDevice] systemVersion] intValue]<5.0){
//        
//        [self setNeedsDisplay];
//        
//    }
//    else
//    {
//        [self setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];
//        
//        
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19], UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,nil];
//        self.titleTextAttributes=dic;
//        
//    }
//    
//}

//- (void)setMyTittle:(NSString *)astring{
//    self.topItem.title=astring;
//    UILabel *alabel=[[UILabel alloc] initWithFrame:self.frame];
//    alabel.textColor=[UIColor blackColor];
//    alabel.font=[UIFont systemFontOfSize:22];
//    alabel.backgroundColor=[UIColor clearColor];
//    alabel.textAlignment=UITextAlignmentCenter;
//    alabel.text=astring;
//    self.topItem.titleView=alabel;
//}

@end
