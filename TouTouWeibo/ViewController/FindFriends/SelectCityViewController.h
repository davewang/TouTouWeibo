//
//  SelectCityViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityViewController : BaseUIViewController<UIActionSheetDelegate>
{
    UIPickerView *cityListPicker;
    UILabel *cityLabel;
    UILabel *districtLabel;
}
@property(retain,nonatomic)UIPickerView *cityListPicker;
@property(retain,nonatomic)UILabel *cityLabel;
@property(retain,nonatomic)UILabel *districtLabel;
@end
