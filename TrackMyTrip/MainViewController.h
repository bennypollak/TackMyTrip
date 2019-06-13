//
//  MainViewController.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "LocHistoryDB.h"


@interface MainViewController : UIViewController {

    NSMutableDictionary *appPrefs; 
    NSString *prefsFilePath;

    
}

-(void)initThis;

-(void)initLocation;


#pragma mark - Actions
- (IBAction)showAct:(id)sender;

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet UITextView *infoText;
@property (weak, nonatomic) IBOutlet UITextView *textViewer;

@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;

- (IBAction)stop:(id)sender;

@end
