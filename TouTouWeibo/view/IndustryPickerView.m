//
//  IndustryPickerView.m
//  ChinaUMS
//
//  Created by Wang Dave on 12-4-12.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "IndustryPickerView.h"
 
@implementation IndustryPickerView
@synthesize pickerView=industryPicker ;
@synthesize industryDelegate;
- (id)initWithFrame:(CGRect)frame  
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        industryPicker =[[UIPickerView alloc] initWithFrame:CGRectMake(0, 480-216, 320, 216)];
        industryPicker.delegate = self;
        industryPicker.dataSource = self;
        industryPicker.showsSelectionIndicator = YES;      // 这个弄成YES, picker中间就会有个条, 被选中的样子
        industryPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,480-216-44, 320, 44)];
        toolBar.tintColor=[UIColor blackColor];
        UIBarButtonItem *button1=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel)];
        
        UIBarButtonItem *button3=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(onOK)];
        //    toolBar.items=
        UIBarButtonItem *button2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
        NSArray * array2=[NSArray arrayWithObjects:button1,button2,button3, nil];
        toolBar.items=array2;  
        [self addSubview:industryPicker];
//        [industryPicker release];
        [self addSubview:toolBar];
        [toolBar release];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"plist"];
        industryArray = [[[NSDictionary alloc] initWithContentsOfFile:path] objectForKey:@"province"];
        subIndustryArray = [[industryArray objectAtIndex:0] objectForKey:@"citys"];
       
    }
    return self;
}
-(void)selectToIndustryId:(NSString *)industryId and:(NSString*)subIndustryId{
    
    NSLog(@"industryArray-------->%@",industryArray );
    for ( int i=0;i<[industryArray count];i++) {
        
         NSLog(@"-------->%@",[industryArray objectAtIndex:i]);
        if ([[[industryArray objectAtIndex:i] objectForKey:@"id"] isEqualToString:industryId]) {
//            if (subIndustryArray) {
//                [subIndustryArray release];
//                subIndustryArray= nil;
//            }
            NSLog(@"-------->%@",[industryArray objectAtIndex:i]);
            subIndustryArray = [[[industryArray objectAtIndex:i] objectForKey:@"citys"] retain];
            NSLog(@"subIndustryArray -->%@",subIndustryArray);
            if (subIndustryId&&subIndustryArray) {
                for (int j=0; j<[subIndustryArray count]; j++) {
                    if ([[[subIndustryArray objectAtIndex:j] objectForKey:@"id"] isEqualToString:subIndustryId]) {
                        NSLog(@"------->%d ,%d",i,j);
                         [self selectToComponent0Index:i andComponent1Index:j];
                     
                        return;
                    }
                }
            }else{
               [self selectToComponent0Index:i andComponent1Index:-1];
            }
            return;
        } 
        
    }
    
}
- (void)show 
{
    [self makeKeyAndVisible];
}
- (void)hide 
{
    [self setHidden:YES];
    
}
- (void)selectToComponent0Index:(NSInteger)index1 andComponent1Index:(NSInteger)index2{
 
    if (index1>-1 && [industryArray count]>index1) {
       
        [industryPicker selectRow:index1 inComponent:0 animated:NO];
//        if (subIndustryArray) {
//            [subIndustryArray release];
//            subIndustryArray= nil;
//        }
      //  subIndustryArray =  [[[industryArray objectAtIndex:index1] objectForKey:@"citys"] retain];
         [industryPicker reloadComponent:1];
         
    }
    
    if (index2>-1 && [subIndustryArray count]>index2) {
        [industryPicker selectRow:index2 inComponent:1 animated:NO];
         [industryPicker reloadComponent:1];
        
    }
}

-(void)onCancel{
    [self setHidden:YES];
}

-(void)onOK{
    
    NSLog(@"industryIndex =%d subIndustryIndex = %d",[industryPicker selectedRowInComponent:0] ,[industryPicker selectedRowInComponent:1]);
    if ([industryDelegate respondsToSelector:@selector(didSelectIndustryPicker:)]) {
        
        NSMutableArray *mutable = [[NSMutableArray alloc] initWithCapacity:2];
        
        if ([industryArray count]> [industryPicker selectedRowInComponent:0]) {
            [mutable addObject:[industryArray objectAtIndex:[industryPicker selectedRowInComponent:0] ] ];
        }
        
        if ([subIndustryArray count]> [industryPicker selectedRowInComponent:1]) {
            [mutable addObject:[subIndustryArray objectAtIndex:[industryPicker selectedRowInComponent:1] ] ];
        }
        
        [industryDelegate didSelectIndustryPicker:[mutable autorelease]];
      
    }
    [self setHidden:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str = @"";
    if (component == 0) {
        
        return [[industryArray objectAtIndex:row] objectForKey:@"name"];
    }
    if (component == 1) {
        if ([subIndustryArray count]>0 ) {
            
             return [[subIndustryArray objectAtIndex:row]objectForKey:@"name"];
        }
       
    }
    return str;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        subIndustryArray =  [[industryArray objectAtIndex:row] objectForKey:@"citys"];
        [industryPicker reloadComponent:1];
    } 
 
    
}
#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [industryArray count];
    }
    if (component == 1) {
        return [subIndustryArray count];
    }
    
    return 0;
}
-(void)dealloc{
    [super dealloc];
    [industryArray release];
    if ([subIndustryArray retainCount]>0) {
        [subIndustryArray release]; 
    }
    
    [industryPicker release];
    
}
@end
