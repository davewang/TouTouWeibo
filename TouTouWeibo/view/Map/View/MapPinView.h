//
//  MapModeViewController.h
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Common/View/AsyncImageView.h>

@interface MapPinView : UIImageView{
  //  AsyncImageView *m_imageView;
    UILabel *m_name;
    UILabel *m_address;
}
//@property(nonatomic,retain)AsyncImageView *m_imageView;
@property(nonatomic,retain)UILabel *m_name;
@property(nonatomic,retain)UILabel *m_address;
-(void)setIMage:(NSString *)imageName name:(NSString *)name address:(NSString *)address;
@end
