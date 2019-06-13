//
//  MainViewController.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "LocManager.h"
#import "MapViewController.h"

@implementation MainViewController
@synthesize stopBtn;
@synthesize createBtn;

@synthesize infoText;
@synthesize textViewer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initThis];
}

- (void)viewDidUnload
{
    [self setInfoText:nil];
    [self setTextViewer:nil];
    [self setStopBtn:nil];
    [self setCreateBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BOOL active =  [[LocManager sharedInstance] active];
    stopBtn.hidden = !active;
    createBtn.hidden = active;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CurrentMap"]) {
        MapViewController *mapView = [segue destinationViewController];
        mapView.ident = [[LocManager sharedInstance]currentIdent];
        //UITableViewCell *cell = sender;        
    }

}

#pragma mark - Initialization
-(void)initThis {
    [self initLocation];
}

#pragma mark - Location

-(void)initLocation {
    [[LocManager sharedInstance] initLocation];
}

#pragma mark - Actions

- (IBAction)stop:(id)sender {
    [[LocManager sharedInstance] stopTracking];
    stopBtn.hidden = 1;
    createBtn.hidden = 0;
}

- (IBAction)showAct:(id)sender {
    NSString *ident = [[LocManager sharedInstance] currentIdent];
    NSArray *locs = [[LocHistoryDB sharedInstance] getLocationsAsCSVForIdent:ident localized:YES];
    textViewer.text = [locs componentsJoinedByString:@"\n"];
}


@end
