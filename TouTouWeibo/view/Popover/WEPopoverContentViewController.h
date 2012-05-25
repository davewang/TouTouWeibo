//
//  WEPopoverContentViewController.h
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WESelectedDelegate<NSObject>

- (void)selectdOneIndex:(NSInteger) index;  
@end


@interface WEPopoverContentViewController : UITableViewController {
    id<WESelectedDelegate> delegate;
    NSArray *data;
}
@property(nonatomic,assign)id<WESelectedDelegate> delegate;
@end
