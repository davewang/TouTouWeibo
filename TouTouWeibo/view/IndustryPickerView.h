//
//  IndustryPickerView.h
//  ChinaUMS
//
//  Created by Wang Dave on 12-4-12.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndustryPickerViewDelegate <NSObject>
@optional 
-(void)didSelectIndustryPicker:(NSArray *)_array;
 
 
@end
  
//行业
@interface IndustryPickerView:UIWindow<UIPickerViewDelegate,UIPickerViewDataSource>
{ 
    
    UIPickerView *industryPicker;
    NSMutableArray *industryArray,*subIndustryArray;
    id industryDelegate;
}

@property(nonatomic,assign)id<IndustryPickerViewDelegate> industryDelegate;
@property(nonatomic,assign) UIPickerView *pickerView;
- (id)initWithFrame:(CGRect)frame andIndustryId:(NSString*)industryId;
-(void)selectToIndustryId:(NSString *)industryId;
- (void)show ;
-(void)hide;
- (void)selectToComponent0Index:(NSInteger)index1 andComponent1Index:(NSInteger)index2;

-(void)selectToIndustryId:(NSString *)industryId and:(NSString*)subIndustryId;
@end
