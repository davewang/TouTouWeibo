//
//  UITableView+setFrameStyle.h
//  ChinaPayOnline
//
//  Created by 彭瑶 on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (setFrameStyle)  


-(void)reSetFrameStyleInRect:(CGRect)rect WithSeparatorCounts:(int)count AndCellHeight:(CGFloat)height;
-(void)reSetBackGroundImage;
@end
