
//
//  MGAutoSizeButton.m
//  TestNav
//
//  Created by 祝本治 on 12-3-25.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MGAutoSizeButton.h"


@implementation MGAutoSizeButton

@synthesize rightImage = rightImage_;
@synthesize titleLabel = label_;

/*- (void)setTitle:(NSString *)title forState:(UIControlState)state
 {
 
 
 }*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.titleLabel = [[UILabel alloc] initWithFrame:frame];
        //self.titleLabel.font 
        self.titleLabel.textColor = NAV_TITLE_COLOR;//[UIColor colorWithRed:74 green:97 blue:124 alpha:1];
       // self.titleLabel.textColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
        //self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:NAV_TITLE_SIZE];
       // self.titleLabel.shadowColor = [UIColor blackColor];
       // self.titleLabel.shadowOffset = CGSizeMake(-1, -1);
        [self.titleLabel setHighlighted:YES];
        [self.titleLabel setHighlightedTextColor:NAV_TITLE_COLOR];
        [self addSubview:self.titleLabel];
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setHighlighted:YES];
        [self setOpaque:NO];
        
    }
    return self;
}

- (void)setRightImage:(UIImage *)rightImage
{
    if (rightImageView_ == nil) {
        rightImageView_ = [[UIImageView alloc] initWithImage:rightImage];
        [self addSubview:rightImageView_];
    }
    else{
        [rightImageView_ setImage:rightImage];
    }
}
- (void)setTitle:(NSString *)title
{
    if(label_ == nil){
        label_ = [[UILabel alloc] initWithFrame:self.bounds];
        label_.textColor = NAV_TITLE_COLOR;//[UIColor whiteColor];
        label_.backgroundColor = [UIColor clearColor];
        label_.textAlignment = UITextAlignmentCenter;
        label_.font = [UIFont boldSystemFontOfSize:NAV_TITLE_SIZE];
//[UIFont fontWithName:@"TrebuchetMS-Bold" size:NAV_TITLE_SIZE];
        [self addSubview:label_];
    }
    [label_ setText:title];
}

- (void)layoutSubviews
{
    NSLog(@"old label:%@",self.titleLabel);
    //[super layoutSubviews];
    NSLog(@"new label:%@",self.titleLabel);
    //[self setAlpha:1];
    //self.contentEdgeInsets = 
    //self.titleLabel.text = [self titleForState:UIControlStateNormal ];
    [self.titleLabel setOpaque:YES];
    //self.titleLabel.highlighted = YES;
    UIFont *font = self.titleLabel.font;
    
    NSLog(@"text:%@",self.titleLabel.text);
    CGSize titleSize = [[self.titleLabel text] sizeWithFont:font];
    
    int labelWidth = titleSize.width;
    int labelHeight = titleSize.height;
    
    //self.titleLabel.bounds = ;
    if (self.titleLabel.bounds.size.width != labelWidth ) {
        self.titleLabel.frame = CGRectMake(0, (self.bounds.size.height - labelHeight)/2, labelWidth + self.titleLabel.bounds.origin.x*2, labelHeight + self.titleLabel.bounds.origin.y * 2);
        NSLog(@"label bounds:%@",NSStringFromCGRect(self.titleLabel.bounds));
        NSLog(@"label frame:@%@",NSStringFromCGRect(self.titleLabel.frame));
        
        
    }
    UIImage *backImage = rightImageView_.image;
    int imageWidth = backImage.size.width;
    int imageHeight = backImage.size.height;
    
    int realWidth = labelWidth + imageWidth + 6 ;
    if (labelWidth + imageWidth + 6 != self.bounds.size.width) {
        UIView *superView = [self superview];
        int superViewWidth = superView.bounds.size.width;
        //int superViewHeight = superView.bounds.size.height;
        
        int x = (superViewWidth - realWidth)/2;
        int y = self.frame.origin.y;
        self.frame = CGRectMake(x, y, realWidth + self.bounds.origin.x * 2, self.frame.size.height);
    }
    rightImageView_.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 6, (self.bounds.size.height - imageHeight)/2, imageWidth, imageHeight);
    NSLog(@"image frame:%@",NSStringFromCGRect(rightImageView_.frame));
    
    
    CGRect buttonFrame = self.bounds;
    CGRect labelFrame = self.titleLabel.frame;
    CGRect imageViewFrame = rightImageView_.frame;
    NSLog(@"buttonFrame:%@",NSStringFromCGRect(buttonFrame));
    NSLog(@"labelFrame:%@",NSStringFromCGRect(labelFrame));
    NSLog(@"imageViewFrame:%@",NSStringFromCGRect(imageViewFrame));
    //[self bringSubviewToFront:label_];
    
}

@end

 
