//
//  MoreViewController.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "LocManager.h"
#import "LocHistoryDB.h"

@implementation MoreViewController {
}
@synthesize distFilterStp;
@synthesize distFilterLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    distFilterStp.minimumValue = 10;
    distFilterStp.maximumValue = 1000;
    distFilterStp.stepValue = 10;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    int val = [[LocManager sharedInstance] distanceFilter];
    
    distFilterLbl.text = [NSString stringWithFormat:@"%d", val];
    distFilterStp.stepValue = val;
}


- (void)viewDidUnload
{
    [self setDistFilterStp:nil];
    [self setDistFilterLbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)distFilter:(id)sender {
    int val = (int)distFilterStp.value;
    distFilterLbl.text = [NSString stringWithFormat:@"%d", val];
    [[LocManager sharedInstance] setDistanceFilter:val];
}

#define kClearLocations 1

- (IBAction)clearAllTripts:(id)sender {
    //[self displayConfirmForTitle:@"Clear location history?" andIndx:kClearLocations];	
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Clear location history?" message:@"" delegate:self 
                                         cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    alert.tag = kClearLocations;
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1)
	{	
		switch (alertView.tag) {
			case kClearLocations: {
				[[LocHistoryDB sharedInstance] clearAll];
			}
                break;
		}
        
	}
}


@end
