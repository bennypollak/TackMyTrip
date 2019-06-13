//
//  DetailViewController.h
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (retain) NSString *ident;
- (IBAction)email:(id)sender;
- (IBAction)insert:(id)sender;
@end
