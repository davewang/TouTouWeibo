 //
//  MapModeViewController.m
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MapPinView.h"

@implementation MapPinView
@synthesize m_name,m_address;//,m_imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [UIImage imageNamed:@"MapPinBg.png"];
    //    m_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(11, 12, 33, 25)];
     //   [self addSubview:m_imageView];
        m_name = [[UILabel alloc] initWithFrame:CGRectMake(46, 14.5, 90, 10)];
        [m_name setFont:[UIFont systemFontOfSize:12]];
        [m_name setBackgroundColor:[UIColor clearColor]];
        [self addSubview:m_name];
        m_address = [[UILabel alloc] initWithFrame:CGRectMake(50, 28, 80, 7)];
        [m_address setFont:[UIFont systemFontOfSize:7]];
        [m_address setBackgroundColor:[UIColor clearColor]];
        [self addSubview:m_address];
        [m_name setTextColor:[UIColor whiteColor]];
        [m_address setTextColor:[UIColor whiteColor]];
    }
    return self;
}
-(void)setIMage:(NSString *)imageName name:(NSString *)name address:(NSString *)address{
    //self.m_imageView.urlString = imageName;
    self.m_name.text = name;
    self.m_address.text = address;
}
-(void)dealloc{
    //[m_imageView release];
    [m_address release];
    [m_name release];
    [super dealloc];
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
