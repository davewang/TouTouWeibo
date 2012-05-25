//
//  MGAutoSizeButton.h
//  TestNav
//
//  Created by 祝本治 on 12-3-25.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAutoSizeButton : UIControl{
@private
    UILabel *label_;
    UIImageView *rightImageView_;
}


@property (nonatomic,retain) UIImage *rightImage;
@property (nonatomic,retain) UILabel *titleLabel;

@end
