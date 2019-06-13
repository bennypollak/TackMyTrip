//
//  DetailViewController.m
//  TrackMyTrip
//
//  Created by Benny Pollak on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "LocHistoryDB.h"

@implementation DetailViewController
@synthesize detailText;
@synthesize ident;

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
    NSArray *locs = [[LocHistoryDB sharedInstance]getLocationsAsCSVForIdent:ident localized:YES];
    detailText.text = [locs componentsJoinedByString:@"\n"];
}

- (void)viewDidUnload
{
    [self setDetailText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)email:(id)sender {
//    NSString *fpath = [self createFile];
//    if (fpath == nil) {
//        return;
//    }
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"A tTrip file TrakMyTrip"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"bpollak@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        NSString *fpath = [NSString stringWithFormat:@"%@.tmtm", ident];
        NSArray *locs = [[LocHistoryDB sharedInstance]getLocationsAsCSVForIdent:ident localized:NO];
        NSString *text = [locs componentsJoinedByString:@"\n"];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        
        //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:data mimeType:@"tripformat/x-tmtm" fileName:fpath]; 
        
        NSString *emailBody = @"...";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
    [controller dismissModalViewControllerAnimated:YES];
}

//-(NSString*)createFile 
//{
//    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *fpath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.tmtm", ident]];
////    NSURL *url = [NSURL fileURLWithPath:fpath];
//    NSError *error;
////    NSFileHandle *file = [NSFileHandle fileHandleForWritingToURL:url error:&error];
//    NSLog(@"Path : %@",fpath);
//    NSArray *locs = [[LocHistoryDB sharedInstance]loadLocationsAsCSVForIdent:ident];
//    NSString *text = [locs componentsJoinedByString:@"\n"];
//    if ([text writeToFile:fpath atomically:NO encoding:NSUTF8StringEncoding error:&error] == NO) {
//        NSLog(@"Error creating file %@: %@", fpath, [error localizedDescription]);
//        return nil;
//    }
//    
//    return fpath;
//}

- (IBAction)insert:(id)sender {
    NSArray *locs = [[LocHistoryDB sharedInstance]getLocationsAsCSVForIdent:ident localized:NO];
    NSString *data = [locs componentsJoinedByString:@"\n"];
    NSString *newident = nil;//[@"_" stringByAppendingString:ident];
    [[LocHistoryDB sharedInstance] insertTripFromString:data  forIdent:newident];
}



@end
