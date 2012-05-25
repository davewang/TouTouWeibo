//
//  VlionActionSheet.m
//  TestActionSheet
//
//  Created by Cui Lionel on 10-12-8.
//  Copyright 2010 vlion. All rights reserved.
//

#import "VlionActionSheet.h"
#define componentCount 2
#define majorComponent 0
#define gradeComponent 1
#define majorComponentWidth 165
#define gradeComponentWidth 70


@implementation VlionActionSheet
@synthesize view;
@synthesize toolBar;
@synthesize cityList;
@synthesize cities;  

NSArray *keys;
id key;
NSString *defaultvalue;
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title
{//height = 84, 134, 184, 234, 284, 334, 384, 434, 484
	self = [super init];
    if (self) 
	{
		int theight = height - 40;
		int btnnum = theight/50;
		for(int i=0; i<btnnum; i++)
		{
			[self addButtonWithTitle:@" "];
		}
		toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		toolBar.barStyle = UIBarStyleBlack;
		
		//UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain target: nil action: nil];
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
		UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
		UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
		NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton,fixedButton, rightButton, nil];
		[toolBar setItems: array];		
		//[titleButton release];
		[leftButton  release];
		[rightButton release];
		[fixedButton release];
		[array       release];
		
		[self addSubview:toolBar];
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, height-44)];
		view.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:view];
       
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"]; 
        self.cities = [[NSDictionary alloc] initWithContentsOfFile:path];
        self.cityList=[[NSMutableArray alloc] init];
         keys = [self.cities  allKeys];

        for(int i = 0; i < [keys count]; i++)
        {        
           key =[keys objectAtIndex:i];
           [self.cityList addObjectsFromArray:[self.cities valueForKey:key]];
        }
        majorNames = [[NSArray alloc]initWithObjects:@"111", @"222", @"333", @"444", @"555", nil];
        
        selectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        selectPicker.showsSelectionIndicator = YES;
        selectPicker.delegate = self;
        selectPicker.dataSource = self;        
        selectPicker.opaque = YES;
		
        [self addSubview:selectPicker]; 
    }
    return self;
}
-(void)done
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)docancel
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -
#pragma mark Picker Date Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.cityList count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.cityList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if (component == kProvinceComponent) {
//        NSString *selectedState = [self.provinces objectAtIndex:row];
//        NSArray *array = [provinceCities objectForKey:selectedState];
//        self.cities = array;
//        [picker selectRow:0 inComponent:kCityComponent animated:YES];
//        [picker reloadComponent:kCityComponent];
//    }
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    if (component == kCityComponent) {
//        return 150;
//    }
//    return 140;
//}

-(void)dealloc
{
     [view release];
     [cities release]; 
     [toolBar release];
     [majorNames release];
     [cityList release];
     [selectPicker release];	
	 [super dealloc];
}
@end
