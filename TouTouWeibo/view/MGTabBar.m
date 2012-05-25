//
//  MGTabBar.m
//  UPPPlugin
//
//  Created by migo on 11-10-9.
//  Copyright 2011年 中科金财电子商务有限公司. All rights reserved.
//

#import "MGTabBar.h"


@implementation MGTabBar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
    
}

- (void)didAddSubview:(UIView *)subview
{
    
    NSArray * subViews = [subview subviews];
    UIView * curSubView = nil;
    for (int i =0; i < [subViews count]; i++) {
        curSubView = (UIView *)[subViews objectAtIndex:i];
        NSLog(@"view at %d class @%@",i,[[curSubView class]description]);
        [curSubView removeFromSuperview];
        //[curSubView release];
    }
    NSString *imageName = [NSString stringWithFormat:@"nav%d_default.png",[[self subviews] count]];
    NSString *imageSelectedName = [NSString stringWithFormat:@"nav%d_on.png",
                                   [[self subviews] count]] ;
    UIImage *normalImage = [UIImage imageNamed:imageName];
    UIImage *highlightImage = [UIImage imageNamed:imageSelectedName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:normalImage highlightedImage:highlightImage];
    
    CGSize imageSize = [normalImage size];
    [imageView setFrame:CGRectMake(0, 0,imageSize.width,imageSize.height)];
    
    [subview addSubview:imageView];
    [imageView release];
    //[normalImage release];
    //[highlightImage release];
    
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem
{
    if([self selectedItem] != selectedItem){
        NSArray * subViews = [self subviews];
        if([self selectedItem] != nil){
            NSArray * subSubViews = [(UIView *)[subViews objectAtIndex:[[self selectedItem] tag]] subviews];
            [((UIImageView *)[subSubViews objectAtIndex:1]) setHighlighted:NO];
        }
        NSArray *subSubViews = [(UIView *)[subViews objectAtIndex:[selectedItem tag]] subviews];
        [((UIImageView *)[subSubViews objectAtIndex:0]) setHighlighted:YES]; 
        [super setSelectedItem:selectedItem];
    }
    
    

}
@end

@implementation MGTabBar(UITabBarDelegateCategory)

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
        
}

@end




