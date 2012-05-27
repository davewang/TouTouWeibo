//
//  SelectCityViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryPickerView.h"
#import "FoundResultViewController.h"

@interface SelectCityViewController : BaseUIViewController<UIActionSheetDelegate,IndustryPickerViewDelegate>
{
    UIPickerView *cityListPicker;
    UILabel *cityLabel;
    UILabel *districtLabel;
    NSString *findType;
    IndustryPickerView *pickerView;
    NSString *currentProviceName;
     NSString *currentCityName;
}
@property(retain,nonatomic)UIPickerView *cityListPicker;
@property(retain,nonatomic)UILabel *cityLabel;
@property(retain,nonatomic)UILabel *districtLabel;
@property(retain,nonatomic)NSString *findType;
@end
