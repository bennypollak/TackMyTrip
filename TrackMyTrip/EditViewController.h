//
//  EditViewControler.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tripName;
@property (strong, nonatomic) IBOutletCollection(UITextView) NSArray *tripNotes;
@property (weak, nonatomic) IBOutlet UITextView *notes;

- (IBAction)tapped:(id)sender;
@end
